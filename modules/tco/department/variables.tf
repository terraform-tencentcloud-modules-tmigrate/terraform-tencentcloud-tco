variable "create" {
  type = bool
  default = true
  description = "create or not"
}

variable "discrete_nodes" {
  default = {}
  type = any
  description = "discrete nodes with parent id specified"
}
variable "l1_org_nodes" {
  default = {}
  type = any
  description = "l1, l2 node starts from root"
}
variable "root_id" {
  default = 0
  type = number
  description = "root id"
}