data "aws_partition" "current" {}

data "aws_elb_service_account" "default" {
  count = module.this.enabled ? 1 : 0
}

data "aws_iam_policy_document" "default" {
  count = module.this.enabled ? 1 : 0

  statement {
    sid = ""
    principals {
      type        = "AWS"
      identifiers = [join("", data.aws_elb_service_account.default.*.arn)]
    }
    effect = "Allow"
    actions = [
      "s3:PutObject"
    ]
    resources = [
      "arn:${data.aws_partition.current.partition}:s3:::${module.this.id}/*",
    ]
  }
  statement {
    sid = ""
    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }
    effect = "Allow"
    actions = [
      "s3:PutObject"
    ]
    resources = [
      "arn:${data.aws_partition.current.partition}:s3:::${module.this.id}/*",
    ]
    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
  statement {
    sid    = ""
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }
    actions = [
      "s3:GetBucketAcl"
    ]
    resources = [
      "arn:${data.aws_partition.current.partition}:s3:::${module.this.id}",
    ]
  }
}

module "access_logs" {
  source     = "cloudposse/s3-log-storage/aws"
  version    = "0.28.0"
  enabled    = module.this.enabled && var.access_logs_enabled && var.access_logs_s3_bucket_id == null
  attributes = compact(concat(module.this.attributes, ["alb", "access", "logs"]))

  acl                                = "log-delivery-write"
  policy                             = join("", data.aws_iam_policy_document.default.*.json)
  force_destroy                      = var.alb_access_logs_s3_bucket_force_destroy
  versioning_enabled                 = true
  lifecycle_rule_enabled             = var.lifecycle_rule_enabled
  enable_glacier_transition          = var.enable_glacier_transition
  expiration_days                    = var.expiration_days
  glacier_transition_days            = var.glacier_transition_days
  noncurrent_version_expiration_days = var.noncurrent_version_expiration_days
  noncurrent_version_transition_days = var.noncurrent_version_transition_days
  standard_transition_days           = var.standard_transition_days

  context = module.this.context
}
