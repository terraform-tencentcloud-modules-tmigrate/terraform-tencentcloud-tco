variable "create" {
  description = "create member or not"
  type        = bool
  default     = true
}

variable "members" {
  default = {}
  type = any
  description = "members"
}


#variable "name" {
#  type        = string
#  description = "Member name"
#}
#
#variable "node_id" {
#  type        = number
#  description = "Organization node ID."
#}
#
#variable "permission_ids" {
#  type        = list(number)
#  default     = []
#  description = "Financial management permission IDs.Valid values:- 1: View bill.- 2: Check balance.- 3: Fund transfer.- 4: Combine bill.- 5: Issue an invoice.- 6: Inherit discount.- 7: Pay on behalf.value 1,2 is required."
#}
#variable "policy_type" {
#  type        = string
#  default     = "Financial"
#  description = " Organization policy type.- Financial: Financial management policy."
#}
#variable "remark" {
#  type    = string
#  default = ""
#}
#variable "pay_uin" {
#  type        = string
#  description = "The uin which is payment account on behalf.When PermissionIds contains 7, is required."
#  default     = null
#}
#
#variable "record_id" {
#  type        = number
#  default     = null
#  description = "Create member record ID.When create failed and needs to be recreated, is required."
#}
#
#variable "region" {
#  type    = string
#  default = "ap-jakarta"
#}
#
#variable "is_allow_quit" {
#  description = "(Optional, String, ForceNew) Whether to allow members to withdraw. Allow: Allow, Disallow: Denied. more see: invite_organization_member_operation"
#  type        = string
#  default     = "Allow"
#}
#
#
## security information bound，An activation email will be sent to this email address after binding.
#variable "enable_bound" {
#  type        = bool
#  description = " security information bound，An activation email will be sent to this email address after binding."
#  default     = false
#}
#
#variable "email" {
#  description = "The email address of the user or contact person."
#  type        = string
#  default     = "1234@gmail.com"
#}
#
#variable "country_code" {
#  description = "The country code for the phone number (e.g., 86 for China)."
#  type        = number
#  default     = 86
#}
#
#variable "phone" {
#  description = "The phone number of the user or contact person, excluding the country code."
#  type        = string
#  default     = "1231231234"
#}