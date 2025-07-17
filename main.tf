locals {
  zone_id = "z-1234567890"
  node_id = "000000000000"

  member_uin_1 = 000000000000
  member_uin_2 = 111111111111

  users = {
    user_1_1 = "cic-user-1-1"
    user_1_2 = "cic-user-1-2"
    user_2_1 = "cic-user-2-1"
    user_2_2 = "cic-user-2-2"
  }

  group_1 = "cic-group-1"
  group_2 = "cic-group-2"

  role_1 = "cic-role-1"
  role_2 = "cic-role-2"

}

module "cic-users" {
  for_each = local.users
  source = "./modules/cic/cic-user-creation"
  zone_id = local.zone_id
  user_name = each.value
}

module "cic-group-1" {
  source = "./modules/cic/cic-group-creation"
  group_name = local.group_1
  zone_id = local.zone_id
  user_ids = [ module.cic-users["user_1_1"].user_id,  module.cic-users["user_1_2"].user_id]
}

module "cic-group-2" {
  source = "./modules/cic/cic-group-creation"
  group_name = local.group_2
  zone_id = local.zone_id
  user_ids = [ module.cic-users["user_2_1"].user_id,  module.cic-users["user_2_2"].user_id]
}

module "cic-role-1" {
  source = "./modules/cic/cic-role/cic-role-creation"
  role_configuration_name = local.role_1
  zone_id = local.zone_id
  policies = [
    "AdministratorAccess"
  ]
}

module "cic-role-2" {
  source = "./modules/cic/cic-role/cic-role-creation"
  role_configuration_name = local.role_2
  zone_id = local.zone_id
  policies = [
    "ReadOnlyAccess"
  ]
}

module "cic-group1-role1-acc1" {
  source = "./modules/cic/cic-role/cic-role-assignment"
  role_id = module.cic-role-1.role_id
#  target_uin = module.member-accs["member_account_1"].org_member_uin
  target_uin = local.member_uin_1
  zone_id = local.zone_id
  principal_type  = "Group"
  principal_id = module.cic-group-1.group_id
}

module "cic-group2-role2-acc2" {
  source = "./modules/cic/cic-role/cic-role-assignment"
  role_id = module.cic-role-2.role_id
#  target_uin = module.member-accs["member_account_2"].org_member_uin
  target_uin = local.member_uin_2
  zone_id = local.zone_id
  principal_type  = "Group"
  principal_id = module.cic-group-2.group_id
}