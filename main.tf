locals {
  # cidrnetmask returns an error for IPv6 addresses
  # cidrhost works with both IPv4 and IPv6, and returns an error if the argument is not a valid IPv4/IPv6 CIDR prefix
  http_ingress_cidr_blocks_v4  = [for cidr in var.http_ingress_cidr_blocks : cidr if can(cidrnetmask(cidr))]
  http_ingress_cidr_blocks_v6  = var.ip_address_type == "dualstack" ? [for cidr in var.http_ingress_cidr_blocks : cidr if !can(cidrnetmask(cidr)) && can(cidrhost(cidr, 0))] : []
  https_ingress_cidr_blocks_v4 = [for cidr in var.https_ingress_cidr_blocks : cidr if can(cidrnetmask(cidr))]
  https_ingress_cidr_blocks_v6 = var.ip_address_type == "dualstack" ? [for cidr in var.https_ingress_cidr_blocks : cidr if !can(cidrnetmask(cidr)) && can(cidrhost(cidr, 0))] : []
}

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
  security_group_id = one(aws_security_group.default[*].id)
}

resource "aws_security_group_rule" "http_ingress" {
  count             = module.this.enabled && var.security_group_enabled && var.http_enabled ? 1 : 0
  type              = "ingress"
  from_port         = var.http_port
  to_port           = var.http_port
  protocol          = "tcp"
  cidr_blocks       = local.http_ingress_cidr_blocks_v4
  ipv6_cidr_blocks  = local.http_ingress_cidr_blocks_v6
  prefix_list_ids   = var.http_ingress_prefix_list_ids
  security_group_id = one(aws_security_group.default[*].id)
}

resource "aws_security_group_rule" "http_ingress_from_security_groups" {
  count                    = module.this.enabled && var.security_group_enabled && var.http_enabled ? length(var.http_ingress_security_group_ids) : 0
  type                     = "ingress"
  from_port                = var.http_port
  to_port                  = var.http_port
  protocol                 = "tcp"
  source_security_group_id = var.http_ingress_security_group_ids[count.index]
  security_group_id        = one(aws_security_group.default[*].id)
}

resource "aws_security_group_rule" "https_ingress" {
  count             = module.this.enabled && var.security_group_enabled && var.https_enabled ? 1 : 0
  type              = "ingress"
  from_port         = var.https_port
  to_port           = var.https_port
  protocol          = "tcp"
  cidr_blocks       = local.https_ingress_cidr_blocks_v4
  ipv6_cidr_blocks  = local.https_ingress_cidr_blocks_v6
  prefix_list_ids   = var.https_ingress_prefix_list_ids
  security_group_id = one(aws_security_group.default[*].id)
}

resource "aws_security_group_rule" "https_ingress_from_security_groups" {
  count                    = module.this.enabled && var.security_group_enabled && var.https_enabled ? length(var.https_ingress_security_group_ids) : 0
  type                     = "ingress"
  from_port                = var.https_port
  to_port                  = var.https_port
  protocol                 = "tcp"
  source_security_group_id = var.https_ingress_security_group_ids[count.index]
  security_group_id        = one(aws_security_group.default[*].id)
}

module "access_logs" {
  source  = "cloudposse/lb-s3-bucket/aws"
  version = "0.19.0"

  enabled = module.this.enabled && var.access_logs_enabled && var.access_logs_s3_bucket_id == null

  attributes = compact(concat(module.this.attributes, ["alb", "access", "logs"]))

  allow_ssl_requests_only       = var.allow_ssl_requests_only
  force_destroy                 = var.alb_access_logs_s3_bucket_force_destroy
  lifecycle_configuration_rules = var.lifecycle_configuration_rules

  lifecycle_rule_enabled             = var.lifecycle_rule_enabled
  enable_glacier_transition          = var.enable_glacier_transition
  expiration_days                    = var.expiration_days
  glacier_transition_days            = var.glacier_transition_days
  noncurrent_version_expiration_days = var.noncurrent_version_expiration_days
  noncurrent_version_transition_days = var.noncurrent_version_transition_days
  standard_transition_days           = var.standard_transition_days

  context = module.this.context
}

module "default_load_balancer_label" {
  source          = "cloudposse/label/null"
  version         = "0.25.0"
  id_length_limit = var.load_balancer_name_max_length
  context         = module.this.context
}

resource "aws_lb" "default" {
  #bridgecrew:skip=BC_AWS_NETWORKING_41 - Skipping Ensure that ALB Drops HTTP Headers
  #bridgecrew:skip=BC_AWS_LOGGING_22 - Skipping Ensure ELBv2 has Access Logging Enabled
  count              = module.this.enabled ? 1 : 0
  name               = var.load_balancer_name == "" ? module.default_load_balancer_label.id : substr(var.load_balancer_name, 0, var.load_balancer_name_max_length)
  tags               = module.this.tags
  internal           = var.internal
  load_balancer_type = "application"

  security_groups = compact(
    concat(var.security_group_ids, [one(aws_security_group.default[*].id)]),
  )

  subnets                          = var.subnet_ids
  enable_cross_zone_load_balancing = var.cross_zone_load_balancing_enabled
  enable_http2                     = var.http2_enabled
  idle_timeout                     = var.idle_timeout
  ip_address_type                  = var.ip_address_type
  enable_deletion_protection       = var.deletion_protection_enabled
  drop_invalid_header_fields       = var.drop_invalid_header_fields
  preserve_host_header             = var.preserve_host_header
  xff_header_processing_mode       = var.xff_header_processing_mode
  client_keep_alive                = var.client_keep_alive

  access_logs {
    bucket  = try(element(compact([var.access_logs_s3_bucket_id, module.access_logs.bucket_id]), 0), "")
    prefix  = var.access_logs_prefix
    enabled = var.access_logs_enabled
  }

  dynamic "minimum_load_balancer_capacity" {
    for_each = var.reserved_capacity_units == null ? [] : [var.reserved_capacity_units]
    content {
      capacity_units = minimum_load_balancer_capacity.value
    }
  }
}

module "default_target_group_label" {
  source          = "cloudposse/label/null"
  version         = "0.25.0"
  attributes      = concat(module.this.attributes, ["default"])
  id_length_limit = var.target_group_name_max_length
  context         = module.this.context
}

resource "aws_lb_target_group" "default" {
  count                             = module.this.enabled && var.default_target_group_enabled ? 1 : 0
  name                              = var.target_group_name == "" ? module.default_target_group_label.id : substr(var.target_group_name, 0, var.target_group_name_max_length)
  port                              = var.target_group_port
  protocol                          = var.target_group_protocol
  protocol_version                  = var.target_group_protocol_version
  vpc_id                            = var.vpc_id
  target_type                       = var.target_group_target_type
  load_balancing_algorithm_type     = var.load_balancing_algorithm_type
  load_balancing_anomaly_mitigation = var.load_balancing_anomaly_mitigation
  deregistration_delay              = var.deregistration_delay
  slow_start                        = var.slow_start

  health_check {
    protocol            = var.health_check_protocol != null ? var.health_check_protocol : var.target_group_protocol
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
  #bridgecrew:skip=BC_AWS_GENERAL_43 - Skipping Ensure that load balancer is using TLS 1.2.
  #bridgecrew:skip=BC_AWS_NETWORKING_29 - Skipping Ensure ALB Protocol is HTTPS
  count = (
    module.this.enabled &&
    var.http_enabled &&
    var.http_redirect != true &&
    (var.listener_http_fixed_response != null || var.default_target_group_enabled)
    ? 1 : 0
  )
  load_balancer_arn = one(aws_lb.default[*].arn)
  port              = var.http_port
  protocol          = "HTTP"
  tags              = merge(module.this.tags, var.listener_additional_tags)

  default_action {
    # target_group_arn is required when type is forward
    target_group_arn = var.listener_http_fixed_response != null ? null : one(aws_lb_target_group.default[*].arn)
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
  load_balancer_arn = one(aws_lb.default[*].arn)
  port              = var.http_port
  protocol          = "HTTP"
  tags              = merge(module.this.tags, var.listener_additional_tags)

  default_action {
    target_group_arn = one(aws_lb_target_group.default[*].arn)
    type             = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
  #bridgecrew:skip=BC_AWS_GENERAL_43 - Skipping Ensure that load balancer is using TLS 1.2.
  count             = module.this.enabled && var.https_enabled ? 1 : 0
  load_balancer_arn = one(aws_lb.default[*].arn)

  port            = var.https_port
  protocol        = "HTTPS"
  ssl_policy      = var.https_ssl_policy
  certificate_arn = var.certificate_arn
  tags            = merge(module.this.tags, var.listener_additional_tags)

  default_action {
    target_group_arn = var.listener_https_fixed_response != null || var.listener_https_redirect != null ? null : one(aws_lb_target_group.default[*].arn)
    type             = var.listener_https_fixed_response != null ? "fixed-response" : var.listener_https_redirect != null ? "redirect" : "forward"

    dynamic "fixed_response" {
      for_each = var.listener_https_fixed_response != null ? [var.listener_https_fixed_response] : []
      content {
        content_type = fixed_response.value["content_type"]
        message_body = fixed_response.value["message_body"]
        status_code  = fixed_response.value["status_code"]
      }
    }

    dynamic "redirect" {
      for_each = var.listener_https_redirect != null ? [var.listener_https_redirect] : []
      content {
        host        = redirect.value["host"]
        path        = redirect.value["path"]
        port        = redirect.value["port"]
        protocol    = redirect.value["protocol"]
        query       = redirect.value["query"]
        status_code = redirect.value["status_code"]
      }
    }
  }
}

resource "aws_lb_listener_certificate" "https_sni" {
  count           = module.this.enabled && var.https_enabled && length(var.additional_certs) > 0 ? length(var.additional_certs) : 0
  listener_arn    = one(aws_lb_listener.https[*].arn)
  certificate_arn = var.additional_certs[count.index]
}
