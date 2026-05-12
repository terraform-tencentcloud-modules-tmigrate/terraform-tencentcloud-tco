variable "create" {
  description = "create service assign or not"
  type        = bool
  default     = true
}

variable "assignments" {
  default     = {}
  type        = any
  description = "organization service assignments"
}

#variable "product_name" {
#  type        = string
#  description = "Organization service product name, e.g. 'WAF'. Used to look up service_id via data source."
#}
#
#variable "member_uins" {
#  type        = list(number)
#  description = "Uin list of the delegated admins. Including up to 20 items."
#}
#
#variable "management_scope" {
#  type        = number
#  default     = 1
#  description = "Management scope of the delegated admin. Valid values: 1 (all members), 2 (partial members). Default value: 1."
#}
#
#variable "management_scope_uins" {
#  type        = list(number)
#  default     = []
#  description = "Uin list of the managed members. This parameter is valid when management_scope is 2."
#}
#
#variable "management_scope_node_ids" {
#  type        = list(number)
#  default     = []
#  description = "ID list of the managed departments. This parameter is valid when management_scope is 2."
#}
