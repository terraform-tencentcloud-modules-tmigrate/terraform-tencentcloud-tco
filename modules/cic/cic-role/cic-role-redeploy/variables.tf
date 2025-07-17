variable "region" {
  type = string
  default = "ap-nanjing"
}
variable "create" {
  type = bool
  default = true
  description = "create or not"
}
variable "zone_id" {
  description = "cic zone id, copy from console"
  type = string
  default = null
}

variable "target_uin" {
  description = "UIN of the synchronized target account of the Tencent Cloud Organization."
  type = number
  default = null
}
variable "target_type" {
  description = "Type of the synchronized target account of the Tencent Cloud Organization. ManagerUin: admin account; MemberUin: member account."
  type = string
  default = "MemberUin"
}
variable "role_id" {
  description = "role to bind"
  type = string
  default = null
}

variable "deployment_status" {
  type = string
  default = ""
  description = "output from cic-role-assignment, if value is DeployedRequired, will trigger the redeploy"
}