
locals {

  members = { for k, v in var.members: k => v if var.create}
  emails = { for k, v in var.members: k => v if var.create && try(v.enable_bound, true)}
  member_uins = { for k, member in tencentcloud_organization_org_member.org_members: k => member.id}
}

resource "tencentcloud_organization_org_member" "org_members" {
  for_each = local.members
  name           = each.value.name
  node_id        = each.value.node_id
  permission_ids = each.value.permission_ids # [ number ]
  policy_type    = each.value.policy_type    # "Financial"
  remark         = try(each.value.remark , "")        # "for terraform test"
  pay_uin        = each.value.pay_uin        #
  record_id      = try(each.value.record_id, null)
}

resource "tencentcloud_organization_org_member_email" "org_member_emails" {
  for_each = local.emails
  member_uin   = local.member_uins[each.key]
  email        = each.value.email
  country_code = try(each.value.country_code, "86")
  phone        = try(each.value.phone, "13800138000")
  lifecycle {
    ignore_changes = [
      email,
      phone
    ]
  }
}