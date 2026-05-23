

locals {
  discrete_nodes = { for k, v in var.discrete_nodes: k => v if var.create }
  l1_nodes = { for k, v in var.l1_org_nodes: k => v if var.create }
  l1_node_ids = { for k, node in tencentcloud_organization_org_node.l1_nodes: k => node.id }

  l2_node_list = flatten(
    [
      for l1_k, l1 in var.l1_org_nodes: [
        for l2_k, l2 in (l1.sub_nodes != null ? l1.sub_nodes : {}): {
          "l1_k"   = l1_k
          "k"      = l2_k
          "name"   = try(l2.name, l2_k)
          "remark" = try(l2.remark, "")
          "tags"   = try(l2.tags, {})
        }
      ] if var.create
    ]
  )
  l2_nodes = { for l2 in local.l2_node_list: l2.k => l2 }
  l2_node_ids = { for k, node in tencentcloud_organization_org_node.l2_nodes: k => node.id }

  discrete_node_ids = { for k, node in tencentcloud_organization_org_node.discrete_nodes: k => node.id}
}

resource "tencentcloud_organization_org_node" "l1_nodes" {
  for_each = local.l1_nodes
  name           = try(each.value.name, each.key)
  parent_node_id = var.root_id
  remark         = try(each.value.remark, "")
  tags           = try(each.value.tags, {})
}

resource "tencentcloud_organization_org_node" "l2_nodes" {
  for_each = local.l2_nodes
  name           = each.value.name
  parent_node_id = local.l1_node_ids[each.value.l1_k]
  remark         = try(each.value.remark, "")
  tags           = try(each.value.tags, {})
}

resource "tencentcloud_organization_org_node" "discrete_nodes" {
  for_each = local.discrete_nodes
  name           = each.value.name
  parent_node_id = each.value.parent_node_id
  remark         = try(each.value.remark, "")
  tags           = try(each.value.tags, {})
}