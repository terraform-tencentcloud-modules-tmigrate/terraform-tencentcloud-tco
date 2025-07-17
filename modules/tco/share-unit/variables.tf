variable "region" {
  type = string
  default = "ap-jakarta"
}
variable "create" {
  description = "create or not"
  default     = true
  type = bool
}

variable "name" {
  type = string
  default = ""
  description = "share unit name"
}
variable "area" {
  default = ""
  type = string
  description = "share unit region"
}
variable "description" {
  description = "unit description"
  type        = string
  default     = ""
}

variable "unit_member_uins" {
  default = []
  type = list(string)
  description = "shared uins"
}


variable "unit_resources" {
  default = {}
  type = any
  description = "shared resources"
}