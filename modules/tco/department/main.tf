

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

  l3_node_list = flatten(
    [
      for l1_k, l1 in var.l1_org_nodes: [
        for l2_k, l2 in (try(l1.sub_nodes, null) != null ? l1.sub_nodes : {}): [
          for l3_k, l3 in (try(l2.sub_nodes, null) != null ? l2.sub_nodes : {}): {
            "l2_k"   = l2_k
            "k"      = l3_k
            "name"   = try(l3.name, l3_k)
            "remark" = try(l3.remark, "")
            "tags"   = try(l3.tags, {})
          }
        ]
      ] if var.create
    ]
  )
  l3_nodes = { for l3 in local.l3_node_list: l3.k => l3 }
  l3_node_ids = { for k, node in tencentcloud_organization_org_node.l3_nodes: k => node.id }

  l4_node_list = flatten(
    [
      for l1_k, l1 in var.l1_org_nodes: [
        for l2_k, l2 in (try(l1.sub_nodes, null) != null ? l1.sub_nodes : {}): [
          for l3_k, l3 in (try(l2.sub_nodes, null) != null ? l2.sub_nodes : {}): [
            for l4_k, l4 in (try(l3.sub_nodes, null) != null ? l3.sub_nodes : {}): {
              "l3_k"   = l3_k
              "k"      = l4_k
              "name"   = try(l4.name, l4_k)
              "remark" = try(l4.remark, "")
              "tags"   = try(l4.tags, {})
            }
          ]
        ]
      ] if var.create
    ]
  )
  l4_nodes = { for l4 in local.l4_node_list: l4.k => l4 }
  l4_node_ids = { for k, node in tencentcloud_organization_org_node.l4_nodes: k => node.id }

  l5_node_list = flatten(
    [
      for l1_k, l1 in var.l1_org_nodes: [
        for l2_k, l2 in (try(l1.sub_nodes, null) != null ? l1.sub_nodes : {}): [
          for l3_k, l3 in (try(l2.sub_nodes, null) != null ? l2.sub_nodes : {}): [
            for l4_k, l4 in (try(l3.sub_nodes, null) != null ? l3.sub_nodes : {}): [
              for l5_k, l5 in (try(l4.sub_nodes, null) != null ? l4.sub_nodes : {}): {
                "l4_k"   = l4_k
                "k"      = l5_k
                "name"   = try(l5.name, l5_k)
                "remark" = try(l5.remark, "")
                "tags"   = try(l5.tags, {})
              }
            ]
          ]
        ]
      ] if var.create
    ]
  )
  l5_nodes = { for l5 in local.l5_node_list: l5.k => l5 }
  l5_node_ids = { for k, node in tencentcloud_organization_org_node.l5_nodes: k => node.id }

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

resource "tencentcloud_organization_org_node" "l3_nodes" {
  for_each = local.l3_nodes
  name           = each.value.name
  parent_node_id = local.l2_node_ids[each.value.l2_k]
  remark         = try(each.value.remark, "")
  tags           = try(each.value.tags, {})
}

resource "tencentcloud_organization_org_node" "l4_nodes" {
  for_each = local.l4_nodes
  name           = each.value.name
  parent_node_id = local.l3_node_ids[each.value.l3_k]
  remark         = try(each.value.remark, "")
  tags           = try(each.value.tags, {})
}

resource "tencentcloud_organization_org_node" "l5_nodes" {
  for_each = local.l5_nodes
  name           = each.value.name
  parent_node_id = local.l4_node_ids[each.value.l4_k]
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