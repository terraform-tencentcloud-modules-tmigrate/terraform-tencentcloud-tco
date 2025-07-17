
variable "create" {
  default = true
  type = bool
  description = "create or not"
}
variable "zone_id" {
  description = "cic zone id, copy from console"
  type = string
  default = ""
}

variable "users" {
  default = {}
  type = any
  description = "users"
}

#variable "description" {
#  default = ""
#  type = string
#}
#variable "display_name" {
#  default = null
#  type = string
#  description = "The display name of the user. Length: Maximum 256 characters."
#}
#variable "email" {
#  default = ""
#  type = string
#  description = "The user's email address. Must be unique within the catalog. Length: Maximum 128 characters."
#}
#variable "first_name" {
#  type = string
#  default = ""
#  description = "The user's first name. Length: Maximum 64 characters."
#}
#variable "user_name" {
#  type = string
#  default = ""
#  description = "User name. It must be unique in space. Modifications are not supported. Format: Contains numbers, English letters and special symbols(+, =, ,, ., @, -, _). Length: Maximum 64 characters."
#}
#variable "last_name" {
#  default = ""
#  description = "The user's last name. Length: Maximum 64 characters."
#  type =string
#}
#variable "user_status" {
#  default = "Enabled"
#  description = "The status of the user. Value: Enabled (default): Enabled. Disabled: Disabled."
#  type = string
#}
