
variable "create" {
  description = "create or not"
  default     = true
  type = bool
}

variable "zone_id" {
  description = "cic zone id, copy from console"
  type = string
  default = ""
}

variable "groups" {
  default = {}
  type = any
  description = "cic groups"
}

#variable "group_name" {
#  description = "create group name"
#  type        = string
#}
#
#variable "description" {
#  default = ""
#  type = string
#}
#
#
#variable "user_ids" {
#  type = list(string)
#  default = []
#  description = "users to attach to this group"
#}