data "tencentcloud_organization_services" "all" {}

output "product_names" {
  value = [for item in data.tencentcloud_organization_services.all.items : item.product_name]
}

output "service_map" {
  value = { for item in data.tencentcloud_organization_services.all.items : item.product_name => item.service_id }
}

locals {
    all_in_one_account = "200048244943"
}

module "tco-service-assign" {
  source = "../../../modules/tco/service-assign"

  assignments = {
    waf = {
      product_name = "Web Application Firewall"
      member_uins  = [local.all_in_one_account]
    }
    csip = {
      product_name = "Cloud Security Center"
      member_uins  = [local.all_in_one_account]
    }
    cvm = {
      product_name = "Cloud Virtual Machine"
      member_uins  = [local.all_in_one_account]
    }
    kms = {
      product_name = "Key Management Service"
      member_uins  = [local.all_in_one_account]
    }
    cloudaudit = {
      product_name = "CloudAudit"
      member_uins  = [local.all_in_one_account]
    }
    billing = {
      product_name = "Billing Center"
      member_uins  = [local.all_in_one_account]
    }
    config = {
      product_name = "Config"
      member_uins  = [local.all_in_one_account]
    }
    quota = {
      product_name = "Quota Center"
      member_uins  = [local.all_in_one_account]
    }
    cic = {
      product_name = "Identity Center Management"
      member_uins  = [local.all_in_one_account]
    }
  }
}
