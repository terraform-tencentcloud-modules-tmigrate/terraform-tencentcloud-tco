
locals {

  roles = { for k, v in var.roles: k => v if var.create}
  role_ids = {for k, role in tencentcloud_identity_center_role_configuration.roles: k => role.role_configuration_id}
  policy_list = flatten([
    for role_k, role in var.roles: [
      for policy in try(role.policies, []): {
        k = format("%s-%s", role_k, policy)
        role_id = local.role_ids[role_k]
        policy: policy
      }
    ]
  ])
  policies = { for policy in local.policy_list: policy.k => policy }

  custom_policies = {
    for k, role in var.roles: k => role if try(role.custom_policies, null) != null
  }
}
// create permission configuration

resource "tencentcloud_identity_center_role_configuration" "roles" {
  for_each = local.roles
  zone_id = var.zone_id
  role_configuration_name = each.value.role_configuration_name
  description             = try(each.value.description, "")
  relay_state = try(each.value.relay_state, null)
  session_duration = try(each.value.session_duration, 3600)
}

# read all pre policies
data "tencentcloud_cam_policies" "all" {
}

locals {
  policy_map = { for policy in data.tencentcloud_cam_policies.all.policy_list: policy.name => policy.policy_id }
}

// permission assign to policy（Assigning preset policies）

resource "tencentcloud_identity_center_role_configuration_permission_policy_attachment" "policies" {
  for_each = local.policies
  zone_id               = var.zone_id
  role_configuration_id = each.value.role_id
  role_policy_id        = lookup(local.policy_map, each.value.policy, each.value.policy)
  role_policy_name      = each.value.policy // fix API new bug， must include policy name
}

resource "tencentcloud_identity_center_role_configuration_permission_custom_policies_attachment" "attachments" {
  for_each = local.custom_policies
  zone_id = var.zone_id
  role_configuration_id = local.role_ids[each.key]
  dynamic "policies" {
    for_each = each.value.custom_policies
    content {
      role_policy_name     = policies.value.role_policy_name
      role_policy_document = policies.value.role_policy_document
    }
  }
}
