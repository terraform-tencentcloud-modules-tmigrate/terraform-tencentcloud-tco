locals {
  zone_id = "z-0123456789"
}

module "cic-provider" {
  source = "../../../modules/cic/cic-identity-provider"
  zone_id    = local.zone_id
  sso_status = "Enabled"

  encoded_metadata_document = base64encode(file("./metadata.xml"))
}
