variable "lifecycle_rule_enabled" {
  type        = bool
  default     = false
  description = <<-EOF
    DEPRECATED: Defaults to `false`, use `lifecycle_configuration_rules` instead.
    When `true`, configures lifecycle events on this bucket using individual (now deprecated) variables."
    EOF
}

variable "enable_glacier_transition" {
  type        = bool
  default     = true
  description = "(Deprecated, use `lifecycle_configuration_rules` instead)\nEnables the transition to AWS Glacier which can cause unnecessary costs for huge amount of small files"
}

variable "glacier_transition_days" {
  type        = number
  default     = 60
  description = "(Deprecated, use `lifecycle_configuration_rules` instead)\nNumber of days after which to move the data to the Glacier Flexible Retrieval storage tier"
}

variable "expiration_days" {
  type        = number
  default     = 90
  description = "(Deprecated, use `lifecycle_configuration_rules` instead)\nNumber of days after which to expunge the objects"
}

variable "noncurrent_version_expiration_days" {
  type        = number
  default     = 90
  description = "(Deprecated, use `lifecycle_configuration_rules` instead)\nSpecifies when non-current object versions expire (in days)"
}

variable "noncurrent_version_transition_days" {
  type        = number
  default     = 30
  description = "(Deprecated, use `lifecycle_configuration_rules` instead)\nSpecifies (in days) when noncurrent object versions transition to Glacier Flexible Retrieval"
}

variable "standard_transition_days" {
  type        = number
  default     = 30
  description = "(Deprecated, use `lifecycle_configuration_rules` instead)\nNumber of days to persist in the standard storage tier before moving to the infrequent access tier"
}