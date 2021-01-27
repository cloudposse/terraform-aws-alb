variable "vpc_id" {
  type        = string
  description = "VPC ID to associate with ALB"
}

variable "subnet_ids" {
  type        = list(string)
  description = "A list of subnet IDs to associate with ALB"
}

variable "security_group_ids" {
  type        = list(string)
  default     = []
  description = "A list of additional security group IDs to allow access to ALB"
}

variable "internal" {
  type        = bool
  default     = false
  description = "A boolean flag to determine whether the ALB should be internal"
}

variable "http_port" {
  type        = number
  default     = 80
  description = "The port for the HTTP listener"
}

variable "http_enabled" {
  type        = bool
  default     = true
  description = "A boolean flag to enable/disable HTTP listener"
}

variable "http_redirect" {
  type        = bool
  default     = false
  description = "A boolean flag to enable/disable HTTP redirect to HTTPS"
}

variable "http_ingress_cidr_blocks" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "List of CIDR blocks to allow in HTTP security group"
}

variable "http_ingress_prefix_list_ids" {
  type        = list(string)
  default     = []
  description = "List of prefix list IDs for allowing access to HTTP ingress security group"
}

variable "certificate_arn" {
  type        = string
  default     = ""
  description = "The ARN of the default SSL certificate for HTTPS listener"
}

variable "https_port" {
  type        = number
  default     = 443
  description = "The port for the HTTPS listener"
}

variable "https_enabled" {
  type        = bool
  default     = false
  description = "A boolean flag to enable/disable HTTPS listener"
}

variable "https_ingress_cidr_blocks" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "List of CIDR blocks to allow in HTTPS security group"
}

variable "https_ingress_prefix_list_ids" {
  type        = list(string)
  default     = []
  description = "List of prefix list IDs for allowing access to HTTPS ingress security group"
}

variable "https_ssl_policy" {
  type        = string
  description = "The name of the SSL Policy for the listener"
  default     = "ELBSecurityPolicy-2015-05"
}

variable "access_logs_prefix" {
  type        = string
  default     = ""
  description = "The S3 log bucket prefix"
}

variable "access_logs_enabled" {
  type        = bool
  default     = true
  description = "A boolean flag to enable/disable access_logs"
}

variable "cross_zone_load_balancing_enabled" {
  type        = bool
  default     = true
  description = "A boolean flag to enable/disable cross zone load balancing"
}

variable "http2_enabled" {
  type        = bool
  default     = true
  description = "A boolean flag to enable/disable HTTP/2"
}

variable "idle_timeout" {
  type        = number
  default     = 60
  description = "The time in seconds that the connection is allowed to be idle"
}

variable "ip_address_type" {
  type        = string
  default     = "ipv4"
  description = "The type of IP addresses used by the subnets for your load balancer. The possible values are `ipv4` and `dualstack`."
}

variable "deletion_protection_enabled" {
  type        = bool
  default     = false
  description = "A boolean flag to enable/disable deletion protection for ALB"
}

variable "deregistration_delay" {
  type        = number
  default     = 15
  description = "The amount of time to wait in seconds before changing the state of a deregistering target to unused"
}

variable "health_check_path" {
  type        = string
  default     = "/"
  description = "The destination for the health check request"
}

variable "health_check_port" {
  type        = string
  default     = "traffic-port"
  description = "The port to use for the healthcheck"
}

variable "health_check_timeout" {
  type        = number
  default     = 10
  description = "The amount of time to wait in seconds before failing a health check request"
}

variable "health_check_healthy_threshold" {
  type        = number
  default     = 2
  description = "The number of consecutive health checks successes required before considering an unhealthy target healthy"
}

variable "health_check_unhealthy_threshold" {
  type        = number
  default     = 2
  description = "The number of consecutive health check failures required before considering the target unhealthy"
}

variable "health_check_interval" {
  type        = number
  default     = 15
  description = "The duration in seconds in between health checks"
}

variable "health_check_matcher" {
  type        = string
  default     = "200-399"
  description = "The HTTP response codes to indicate a healthy check"
}

variable "alb_access_logs_s3_bucket_force_destroy" {
  type        = bool
  default     = false
  description = "A boolean that indicates all objects should be deleted from the ALB access logs S3 bucket so that the bucket can be destroyed without error"
}

variable "target_group_port" {
  type        = number
  default     = 80
  description = "The port for the default target group"
}

variable "target_group_protocol" {
  type        = string
  default     = "HTTP"
  description = "The protocol for the default target group HTTP or HTTPS"
}

variable "target_group_name" {
  type        = string
  default     = ""
  description = "The name for the default target group, uses a module label name if left empty"
}

variable "target_group_target_type" {
  type        = string
  default     = "ip"
  description = "The type (`instance`, `ip` or `lambda`) of targets that can be registered with the target group"
}

variable "target_group_additional_tags" {
  type        = map(string)
  default     = {}
  description = "The additional tags to apply to the target group"
}

variable "listener_http_fixed_response" {
  description = "Have the HTTP listener return a fixed response for the default action."
  type = object({
    content_type = string
    message_body = string
    status_code  = string
  })
  default = null
}

variable "listener_https_fixed_response" {
  description = "Have the HTTPS listener return a fixed response for the default action."
  type = object({
    content_type = string
    message_body = string
    status_code  = string
  })
  default = null
}

variable "lifecycle_rule_enabled" {
  type        = bool
  description = "A boolean that indicates whether the s3 log bucket lifecycle rule should be enabled."
  default     = false
}

variable "enable_glacier_transition" {
  type        = bool
  description = "Enables the transition of lb logs to AWS Glacier"
  default     = true
}

variable "glacier_transition_days" {
  type        = number
  description = "Number of days after which to move s3 logs to the glacier storage tier"
  default     = 60
}

variable "expiration_days" {
  type        = number
  description = "Number of days after which to expunge s3 logs"
  default     = 90
}

variable "noncurrent_version_expiration_days" {
  type        = number
  description = "Specifies when noncurrent s3 log versions expire"
  default     = 90
}

variable "noncurrent_version_transition_days" {
  type        = number
  description = "Specifies when noncurrent s3 log versions transition"
  default     = 30
}

variable "standard_transition_days" {
  type        = number
  description = "Number of days to persist logs in standard storage tier before moving to the infrequent access tier"
  default     = 30
}

variable "stickiness" {
  type = object({
    cookie_duration = number
    enabled         = bool
  })
  description = "Target group sticky configuration"
  default     = null
}

variable "additional_certs" {
  type        = list(string)
  description = "A list of additonal certs to add to the https listerner"
  default     = []
}

variable "security_group_enabled" {
  type        = bool
  description = "Enables the security group"
  default     = true
}
