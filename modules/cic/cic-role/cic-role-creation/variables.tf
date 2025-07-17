
variable "create" {
  description = "create or not"
  default     = true
  type = bool
}

variable "roles" {
  default = {}
  type = any
  description = "roles"
}

variable "zone_id" {
  type = string
  default = ""
  description = "cic zone id"
}

#variable "role_configuration_name" {
#  description = "permission name"
#  type        = string
#}
#
#variable "description" {
#  description = "permission description"
#  type        = string
#  default     = ""
#}
#
#variable "relay_state" {
#  default = null
#  type =string
#  description = "Initial access page. It indicates the initial access page URL when CIC users use the access configuration to access the target account of the Tencent Cloud Organization. This page must be the Tencent Cloud console page. The default is null, which indicates navigating to the home page of the Tencent Cloud console."
#}
#variable "session_duration" {
#  default = 3600
#  type = number
#  description = "Session duration. It indicates the maximum session duration when CIC users use the access configuration to access the target account of the Tencent Cloud Organization. Unit: seconds. Value range: 900-43,200 (15 minutes to 12 hours). Default value: 3600 (1 hour)"
#}
#
#variable "policies" {
#  type = list(string)
#  default = []
#  description = "policies to attach to this role"
#}
#
#variable "create_custom_policy" {
#  description = "create or not"
#  default     = false
#  type        = bool
#}
#
#variable "custom_policy_name" {
#  description = "(Required, String, ForceNew) Role policy name."
#  default     = "default-policy"
#  type = string
#}
#
#variable "custom_policy_document" {
#  description = "(Required, String, ForceNew) Role policy document."
#  type = string
#  default = "{}"
#}
#
#variable "create_custom_policies" {
#  description = "create multi custom policies"
#  default = false
#  type = bool
#}
#variable "custom_policies" {
#  default = {}
#  type = any
#  description = "multi custom policies"
#}
