locals {
  zone_id = "z-0123456789"
}

module "cic-users" {
  source = "../../../modules/cic/cic-user-creation"
  zone_id = local.zone_id
  users = {
    "admin1@abc.com" = {
      user_name = "admin1@abc.com"
      email = "admin1@abc.com"
    }
    "admin2@abc.com" = {
      user_name = "admin2@abc.com"
      email = "user2@abc.com"
    }
    "app1_dev@abc.com" = {
      user_name = "app1_dev@abc.com"
      email = "app1_dev@abc.com"
    }
    "app2_dev@abc.com" = {
      user_name = "app2_dev@abc.com"
      email = "app2_dev@abc.com"
    }
  }
}