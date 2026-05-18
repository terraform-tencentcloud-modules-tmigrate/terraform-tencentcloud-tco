data "tencentcloud_identity_center_groups" "all" {
  zone_id = var.zone_id
}

data "tencentcloud_identity_center_users" "all" {
  zone_id = var.zone_id
}

locals {
  # group_name -> group_id
  group_ids = {
    for g in data.tencentcloud_identity_center_groups.all.groups : g.group_name => g.group_id
  }

  # user_name -> user_id
  user_ids = {
    for u in data.tencentcloud_identity_center_users.all.users : u.user_name => u.user_id
  }

  # flatten to list of { key, group_id, user_id } for for_each
  attachments = {
    for obj in flatten([
      for g_name, user_names in var.group_user_map : [
        for u_name in user_names : {
          key      = format("%s-%s", g_name, u_name)
          group_id = local.group_ids[g_name]
          user_id  = local.user_ids[u_name]
        }
      ]
    ]) : obj.key => obj
  }
}

resource "tencentcloud_identity_center_user_group_attachment" "attachment" {
  for_each = local.attachments
  zone_id  = var.zone_id
  group_id = each.value.group_id
  user_id  = each.value.user_id
}
