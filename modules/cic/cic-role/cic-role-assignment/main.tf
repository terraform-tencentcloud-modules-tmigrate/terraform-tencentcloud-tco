
locals {
#  deployment_status = var.create ? concat(data.tencentcloud_role_configuration_provisionings.role_configuration_provisionings.*, [{role_configuration_provisionings: [{deployment_status: ""}]}])[0].role_configuration_provisionings[0].deployment_status : ""
  assignments = { for k, v in var.assignments: k => v if var.create }

}


resource "tencentcloud_identity_center_role_assignment" "identity_center_role_assignment" {
  for_each = local.assignments
  zone_id               = var.zone_id
  principal_id          = each.value.principal_id
  principal_type        = each.value.principal_type // "Group"
  target_uin            = each.value.target_uin
  target_type           = each.value.target_type
  role_configuration_id = each.value.role_configuration_id
  deprovision_strategy = try(each.value.deprovision_strategy, "None")
}

#data "tencentcloud_role_configuration_provisionings" "role_configuration_provisionings" {
#  count = var.create ? 1 : 0
#  depends_on = [ tencentcloud_identity_center_role_assignment.identity_center_role_assignment ]
#  zone_id               = var.zone_id
#  role_configuration_id = var.role_id
#}

