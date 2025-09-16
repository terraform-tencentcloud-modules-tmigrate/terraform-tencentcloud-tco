locals {
  zone_id = "z-0123456789"
}

module "cic-groups" {
  source = "../../../modules/cic/cic-group-creation"
  zone_id = local.zone_id
  groups = {
    admin_group = {
      group_name = "admin_group"
      users = [
        200000001,
        200000002
      ]
    }
    app1-group = {
      group_name = "app1-group"
      users = [
        20000003
      ]
    }
    app2-group = {
      group_name = "app2-group"
      users = [
        20000004
      ]
    }
  }
}

