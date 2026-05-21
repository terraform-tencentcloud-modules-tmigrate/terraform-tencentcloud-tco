variable "create" {
  type        = bool
  default     = true
  description = "Whether to create resources."
}

variable "zone_id" {
  description = "CIC zone ID."
  type        = string
  default     = ""
}

variable "group_assignments" {
  description = "Role assignments for groups. Map key is assignment identifier. Each value has principal_name (group name), target_uin, target_type, role_configuration_id, and optional deprovision_strategy."
  type = map(object({
    principal_name        = string
    target_uin            = number
    target_type           = string
    role_configuration_id = string
    deprovision_strategy  = optional(string, "None")
  }))
  default = {}
}

variable "user_assignments" {
  description = "Role assignments for users. Map key is assignment identifier. Each value has principal_name (user name), target_uin, target_type, role_configuration_id, and optional deprovision_strategy."
  type = map(object({
    principal_name        = string
    target_uin            = number
    target_type           = string
    role_configuration_id = string
    deprovision_strategy  = optional(string, "None")
  }))
  default = {}
}
