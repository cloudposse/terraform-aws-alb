variable "namespace" {
  description = "Namespace, which could be your organization name, e.g. `cp` or `cloudposse`"
}

variable "stage" {
  description = "Stage, e.g. `prod`, `staging`, `dev`, or `test`"
}

variable "name" {
  description = "Solution name, e.g. `app`"
}

variable "enabled" {
  description = "Set to false to prevent the module from creating any resources"
  default     = "true"
}

variable "delimiter" {
  type        = "string"
  default     = "-"
  description = "Delimiter to be used between `namespace`, `name`, `stage` and `attributes`"
}

variable "attributes" {
  type        = "list"
  default     = []
  description = "Additional attributes, e.g. `1`"
}

variable "tags" {
  type        = "map"
  default     = {}
  description = "Additional tags (e.g. `map(`BusinessUnit`,`XYZ`)"
}

variable "vpc_id" {
  type = "string"
}

variable "subnet_ids" {
  type = "list"
}

variable "internal" {
  default = "false"
}

variable "http_port" {
  default = "80"
}

variable "http_enabled" {
  default = "true"
}

variable "http_ingress_cidr_blocks" {
  type    = "list"
  default = ["0.0.0.0/0"]
}

variable "http_ingress_prefix_list_ids" {
  type    = "list"
  default = []
}

variable "certificate_arn" {
  default = ""
}

variable "https_port" {
  default = "80"
}

variable "https_enabled" {
  default = "true"
}

variable "https_ingress_cidr_blocks" {
  type    = "list"
  default = ["0.0.0.0/0"]
}

variable "https_ingress_prefix_list_ids" {
  type    = "list"
  default = []
}

variable "access_logs_prefix" {
  default = ""
}

variable "access_logs_enabled" {
  default = "true"
}

variable "cross_zone_load_balancing_enabled" {
  default = "true"
}

variable "http2_enabled" {
  default = "true"
}

variable "idle_timeout" {
  default = "60"
}

variable "ip_address_type" {
  description = "The type of IP addresses used by the subnets for your load balancer. The possible values are `ipv4` and `dualstack`."
  default     = "dualstack"
}

variable "deletion_protection_enabled" {
  default = "false"
}
