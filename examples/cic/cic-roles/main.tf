locals {
  zone_id = "z-0123456789"
}

module "cic-roles" {
  source = "../../../modules/cic/cic-role/cic-role-creation"
  zone_id = local.zone_id
  roles = {
    admin = {
      role_configuration_name = "admin"
      policies = [
        "AdministratorAccess"
      ]
    }
    readonly = {
      role_configuration_name = "readonly"
      policies = [
        "ReadOnlyAccess"
      ]
    }
    app1-dev = {
      role_configuration_name = "app1-dev"
      custom_policies = {
        app1_network = {
          role_policy_name     = "app1_dev_network"
          role_policy_document = <<-EOF
{
    "version": "2.0",
    "statement": [
        {
            "effect": "allow",
            "action": [
                "vpc:*"
            ],
            "resource": [
                "*"
            ],
            "condition": {
                "string_equal": {
                    "qcs:resource_tag": "app&app1"
                }
            }
        },
        {
            "effect": "allow",
            "action": [
                "organization:*"
            ],
            "resource": [
                "*"
            ]
        }
    ]
}
EOF
        }
      }
    }
    app2-dev = {
      role_configuration_name = "app2-dev"
      custom_policies = {
        app1_network = {
          role_policy_name     = "app2_dev_network"
          role_policy_document = <<-EOF
{
    "version": "2.0",
    "statement": [
        {
            "effect": "allow",
            "action": [
                "vpc:*"
            ],
            "resource": [
                "*"
            ],
            "condition": {
                "string_equal": {
                    "qcs:resource_tag": "app&app2"
                }
            }
        }
    ]
}
EOF
        }
      }
    }
  }
}


module "cic-role-assignment" {
  source = "../../../modules/cic/cic-role/cic-role-assignment"
  zone_id = local.zone_id
  assignments = {
    admin-group = {
      principal_id          = 20000001
      principal_type        = "Group"// "Group"
      target_uin            = 100000001
      target_type           = "MemberUin"
      role_configuration_id = 30000001
    }
    app-app1-group = {
      principal_id          = 20000002
      principal_type        = "Group"// "Group"
      target_uin            = 100000001
      target_type           = "MemberUin"
      role_configuration_id = 30000002
    }
    app-app2-group = {
      principal_id          = 20000003
      principal_type        = "Group"// "Group"
      target_uin            = 100000001
      target_type           = "MemberUin"
      role_configuration_id = 30000002
    }
  }
}

