locals {
  root_id = 0 # your organization root id

  l1_nodes = {
    department-1 = {
      name     = "department-1"
      accounts = {
        department-1-admin = {
          name           = "department-1-admin"
          permission_ids = [1, 2, 4, 7] # [ number ]
          policy_type    = "Financial"    # "Financial"
          remark         = "created by terraform"        # "for terraform test"
          pay_uin        = "000000000000"        #
          email          = "0000000000@qq.com"
          country_code   = "86"
          phone          = "13800138000"
        }
      }
    }
  }
  l1_member_creation_list = flatten([
    for l1_k, l1 in local.l1_nodes: [
      for m_k, member in try(l1.accounts, {}): merge(member, {
        k = format("%s-%s", l1_k , m_k)
        node_id = module.tco-department.l1_nodes[l1_k]
      })
    ]
  ])
  member_creations = {
    for l1_member in local.l1_member_creation_list: l1_member.k => l1_member
  }
}

module "tco-department" {
  source = "../../../modules/tco/department"
  l1_org_nodes = local.l1_nodes
  root_id = local.root_id
}

output "department-all" {
  value = module.tco-department
}

module "tco-members" {
  source = "../../../modules/tco/member-account-creation"
  members = local.member_creations
}
output "members" {
  value = module.tco-members
}