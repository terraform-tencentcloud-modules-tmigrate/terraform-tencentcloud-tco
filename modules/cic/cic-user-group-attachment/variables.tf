variable "zone_id" {
  description = "CIC zone id, copy from console"
  type        = string
}

variable "group_user_map" {
  description = "Map of group_name -> list of user_names. Module will look up group_id and user_id by name."
  type        = map(list(string))
  default     = {}
}
