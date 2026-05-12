data "tencentcloud_organization_services" "all" {}

locals {
  assignments = { for k, v in var.assignments : k => v if var.create && length(try(v.member_uins, [])) > 0 }

  # product_name -> service_id map (exclude Control Center which does not support service assign)
  service_map = { for item in data.tencentcloud_organization_services.all.items : item.product_name => item.service_id if item.product_name != "Control Center" }
}

resource "tencentcloud_organization_service_assign" "service_assign" {
  for_each = local.assignments

  service_id                = local.service_map[each.value.product_name]
  member_uins               = each.value.member_uins
  management_scope          = try(each.value.management_scope, 1)
  management_scope_uins     = try(each.value.management_scope_uins, [])
  management_scope_node_ids = try(each.value.management_scope_node_ids, [])
}
