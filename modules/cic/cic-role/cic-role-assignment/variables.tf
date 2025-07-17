
variable "create" {
  type = bool
  default = true
  description = "create or not"
}
variable "zone_id" {
  description = "cic zone id, copy from console"
  type = string
  default = ""
}

variable "assignments" {
  default = {}
  type = any
}

#variable "principal_id" {
#  description = "user or group id to sync cam role ans user"
#  type = string
#}
#variable "target_uin" {
#  description = "UIN of the synchronized target account of the Tencent Cloud Organization."
#  type = number
#}
#variable "target_type" {
#  description = "Type of the synchronized target account of the Tencent Cloud Organization. ManagerUin: admin account; MemberUin: member account."
#  type = string
#  default = "MemberUin"
#}
#variable "role_id" {
#  description = "role to bind"
#  type = string
#}
#variable "principal_type" {
#  type = string
#  default = "Group"
#  description = "User: indicates that the identity for the CAM user synchronization is a CIC user. Group: indicates that the identity for the CAM user synchronization is a CIC user group."
#}
#variable "deprovision_strategy" {
#  description = "When you remove the last authorization configured with a certain privilege on a group account target account, whether to cancel the privilege configuration deployment at the same time. Value: DeprovisionForLastRoleAssignmentOnAccount: Remove privileges to configure deployment. None (default): Configure deployment without delegating privileges."
#  default = "None"
#  type = string
#}

#variable "deletion_strategy" {
#  description = " Deletion policy. It indicates the handling policy for CAM users already synchronized when the CAM user synchronization is deleted. Valid values: Delete: Delete the CAM users already synchronized from CIC to CAM when the CAM user synchronization is deleted; Keep: Keep the CAM users already synchronized from CIC to CAM when the CAM user synchronization is deleted."
#  type = string
#  default = "Delete"
#}
#variable "duplication_strategy" {
#  description = "Conflict policy. It indicates the handling policy for existence of a user with the same username when CIC users are synchronized to CAM. Valid values: KeepBoth: Keep both, that is, add the _cic suffix to the CIC user's username and then try to create a CAM user with the username when CIC users are synchronized to CAM and a user with the same username already exists in CAM; TakeOver: Replace, that is, directly replace the existing CAM user with the synchronized CIC user when CIC users are synchronized to CAM and a user with the same username already exists in CAM."
#  type = string
#  default = "TakeOver"
#}