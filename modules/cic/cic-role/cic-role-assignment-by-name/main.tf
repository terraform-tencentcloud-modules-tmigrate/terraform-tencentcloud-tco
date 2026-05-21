data "tencentcloud_identity_center_groups" "groups" {
  zone_id = var.zone_id
}

data "tencentcloud_identity_center_users" "users" {
  zone_id = var.zone_id
}

locals {
  group_name_to_id = {
    for g in data.tencentcloud_identity_center_groups.groups.groups : g.group_name => g.group_id
  }

  user_name_to_id = {
    for u in data.tencentcloud_identity_center_users.users.users : u.user_name => u.user_id
  }

  group_assignments = { for k, v in var.group_assignments : k => v if var.create }
  user_assignments  = { for k, v in var.user_assignments : k => v if var.create }
}

resource "tencentcloud_identity_center_role_assignment" "group_assignment" {
  for_each = local.group_assignments

  zone_id               = var.zone_id
  principal_id          = local.group_name_to_id[each.value.principal_name]
  principal_type        = "Group"
  target_uin            = each.value.target_uin
  target_type           = each.value.target_type
  role_configuration_id = each.value.role_configuration_id
  deprovision_strategy  = try(each.value.deprovision_strategy, "None")
}

resource "tencentcloud_identity_center_role_assignment" "user_assignment" {
  for_each = local.user_assignments

  zone_id               = var.zone_id
  principal_id          = local.user_name_to_id[each.value.principal_name]
  principal_type        = "User"
  target_uin            = each.value.target_uin
  target_type           = each.value.target_type
  role_configuration_id = each.value.role_configuration_id
  deprovision_strategy  = try(each.value.deprovision_strategy, "None")
}
