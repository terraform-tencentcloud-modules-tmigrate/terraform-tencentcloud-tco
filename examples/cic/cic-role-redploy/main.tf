locals {
  zone_id = "z-0123456789"
  role_configuration_id = 30000001
}

data "tencentcloud_role_configuration_provisionings" "role_configuration_provisionings_app1_dev" {
  zone_id               = local.zone_id
  role_configuration_id = local.role_configuration_id
}

resource "null_resource" "redeploy_trigger" {
  count = data.tencentcloud_role_configuration_provisionings.role_configuration_provisionings_app1_dev.role_configuration_provisionings[0].deployment_status == "DeployedRequired" ? 1 : 0
  triggers = {
    always_run = timestamp()
  }
}

resource "tencentcloud_provision_role_configuration_operation" "provision_role_configuration_operation" {
  zone_id               = local.zone_id
  role_configuration_id = local.role_configuration_id
  target_type           = "MemberUin"
  target_uin            = 100000001

  lifecycle {
    replace_triggered_by = [
      null_resource.redeploy_trigger
    ]
  }
}