resource "aws_security_group" "default" {
  count       = module.this.enabled && var.security_group_enabled ? 1 : 0
  description = "Controls access to the ALB (HTTP/HTTPS)"
  vpc_id      = var.vpc_id
  name        = module.this.id
  tags        = module.this.tags
}

resource "aws_security_group_rule" "egress" {
  count             = module.this.enabled && var.security_group_enabled ? 1 : 0
  type              = "egress"
  from_port         = "0"
  to_port           = "0"
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = join("", aws_security_group.default.*.id)
}

resource "aws_security_group_rule" "http_ingress" {
  count             = module.this.enabled && var.security_group_enabled && var.http_enabled ? 1 : 0
  type              = "ingress"
  from_port         = var.http_port
  to_port           = var.http_port
  protocol          = "tcp"
  cidr_blocks       = var.http_ingress_cidr_blocks
  prefix_list_ids   = var.http_ingress_prefix_list_ids
  security_group_id = join("", aws_security_group.default.*.id)
}

resource "aws_security_group_rule" "https_ingress" {
  count             = module.this.enabled && var.security_group_enabled && var.https_enabled ? 1 : 0
  type              = "ingress"
  from_port         = var.https_port
  to_port           = var.https_port
  protocol          = "tcp"
  cidr_blocks       = var.https_ingress_cidr_blocks
  prefix_list_ids   = var.https_ingress_prefix_list_ids
  security_group_id = join("", aws_security_group.default.*.id)
}

module "access_logs" {
  source                             = "cloudposse/lb-s3-bucket/aws"
  version                            = "0.11.4"
  enabled                            = module.this.enabled && var.access_logs_enabled
  name                               = module.this.name
  namespace                          = module.this.namespace
  stage                              = module.this.stage
  environment                        = module.this.environment
  attributes                         = compact(concat(module.this.attributes, ["alb", "access", "logs"]))
  delimiter                          = module.this.delimiter
  tags                               = module.this.tags
  lifecycle_rule_enabled             = var.lifecycle_rule_enabled
  enable_glacier_transition          = var.enable_glacier_transition
  expiration_days                    = var.expiration_days
  glacier_transition_days            = var.glacier_transition_days
  noncurrent_version_expiration_days = var.noncurrent_version_expiration_days
  noncurrent_version_transition_days = var.noncurrent_version_transition_days
  standard_transition_days           = var.standard_transition_days
  force_destroy                      = var.alb_access_logs_s3_bucket_force_destroy
}

resource "aws_lb" "default" {
  count              = module.this.enabled ? 1 : 0
  name               = module.this.id
  tags               = module.this.tags
  internal           = var.internal
  load_balancer_type = "application"

  security_groups = compact(
    concat(var.security_group_ids, [join("", aws_security_group.default.*.id)]),
  )

  subnets                          = var.subnet_ids
  enable_cross_zone_load_balancing = var.cross_zone_load_balancing_enabled
  enable_http2                     = var.http2_enabled
  idle_timeout                     = var.idle_timeout
  ip_address_type                  = var.ip_address_type
  enable_deletion_protection       = var.deletion_protection_enabled

  access_logs {
    bucket  = module.access_logs.bucket_id
    prefix  = var.access_logs_prefix
    enabled = var.access_logs_enabled
  }
}

module "default_target_group_label" {
  source     = "cloudposse/label/null"
  version    = "0.24.1"
  attributes = concat(module.this.attributes, ["default"])
  context    = module.this.context
}

resource "aws_lb_target_group" "default" {
  count                = module.this.enabled ? 1 : 0
  name                 = var.target_group_name == "" ? module.default_target_group_label.id : var.target_group_name
  port                 = var.target_group_port
  protocol             = var.target_group_protocol
  vpc_id               = var.vpc_id
  target_type          = var.target_group_target_type
  deregistration_delay = var.deregistration_delay

  health_check {
    protocol            = var.target_group_protocol
    path                = var.health_check_path
    port                = var.health_check_port
    timeout             = var.health_check_timeout
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
    interval            = var.health_check_interval
    matcher             = var.health_check_matcher
  }

  dynamic "stickiness" {
    for_each = var.stickiness == null ? [] : [var.stickiness]
    content {
      type            = "lb_cookie"
      cookie_duration = stickiness.value.cookie_duration
      enabled         = var.target_group_protocol == "TCP" ? false : stickiness.value.enabled
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    module.default_target_group_label.tags,
    var.target_group_additional_tags
  )
}

resource "aws_lb_listener" "http_forward" {
  count             = var.http_enabled && var.http_redirect != true ? 1 : 0
  load_balancer_arn = join("", aws_lb.default.*.arn)
  port              = var.http_port
  protocol          = "HTTP"

  default_action {
    target_group_arn = var.listener_http_fixed_response != null ? null : join("", aws_lb_target_group.default.*.arn)
    type             = var.listener_http_fixed_response != null ? "fixed-response" : "forward"

    dynamic "fixed_response" {
      for_each = var.listener_http_fixed_response != null ? [var.listener_http_fixed_response] : []
      content {
        content_type = fixed_response.value["content_type"]
        message_body = fixed_response.value["message_body"]
        status_code  = fixed_response.value["status_code"]
      }
    }
  }
}

resource "aws_lb_listener" "http_redirect" {
  count             = module.this.enabled && var.http_enabled && var.http_redirect == true ? 1 : 0
  load_balancer_arn = join("", aws_lb.default.*.arn)
  port              = var.http_port
  protocol          = "HTTP"

  default_action {
    target_group_arn = join("", aws_lb_target_group.default.*.arn)
    type             = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
  count             = module.this.enabled && var.https_enabled ? 1 : 0
  load_balancer_arn = join("", aws_lb.default.*.arn)

  port            = var.https_port
  protocol        = "HTTPS"
  ssl_policy      = var.https_ssl_policy
  certificate_arn = var.certificate_arn

  default_action {
    target_group_arn = var.listener_https_fixed_response != null ? null : join("", aws_lb_target_group.default.*.arn)
    type             = var.listener_https_fixed_response != null ? "fixed-response" : "forward"

    dynamic "fixed_response" {
      for_each = var.listener_https_fixed_response != null ? [var.listener_https_fixed_response] : []
      content {
        content_type = fixed_response.value["content_type"]
        message_body = fixed_response.value["message_body"]
        status_code  = fixed_response.value["status_code"]
      }
    }
  }
}

resource "aws_lb_listener_certificate" "https_sni" {
  count           = module.this.enabled && var.https_enabled && var.additional_certs != [] ? length(var.additional_certs) : 0
  listener_arn    = join("", aws_lb_listener.https.*.arn)
  certificate_arn = var.additional_certs[count.index]
}
