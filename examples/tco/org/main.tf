module "tco-org" {
  source = "../../../modules/tco/org"
  org_name = "test-organization"
}
output "org-all" {
  value = module.tco-org
}