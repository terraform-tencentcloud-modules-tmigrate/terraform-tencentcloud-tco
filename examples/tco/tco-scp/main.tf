locals {
  # TODO: replace with your org root_id and target node_ids
  root_id = 200002000455

  target_nodes = {
    root = {
      node_id = local.root_id
    }
  }

  policies = {
    deny-cvm-public-ip = {
      policy_name = "DenyCvmPublicIp"
      description = "Deny launching CVM instances with public IP"
      content = jsonencode({
        version   = "2.0"
        statement = [
          {
            effect   = "deny"
            action   = ["cvm:RunInstances"]
            resource = ["*"]
            condition = {
              string_not_equal_if_exist = {
                "cvm:publicIp" = "false"
              }
            }
          }
        ]
      })
    }

    deny-cos-public-bucket = {
      policy_name = "DenyCosPublicBucket"
      description = "Deny setting COS bucket ACL to non-private"
      content = jsonencode({
        version   = "2.0"
        statement = [
          {
            effect   = "deny"
            action   = ["cos:GetBucketACL", "cos:PutBucketACL"]
            resource = ["*"]
            condition = {
              string_not_equal_if_exist = {
                "cos:x-cos-acl" = "private"
              }
            }
          }
        ]
      })
    }

    deny-iam-user-creation = {
      policy_name = "DenyIamUserCreation"
      description = "Deny creating CAM sub-accounts and users"
      content = jsonencode({
        version   = "2.0"
        statement = [
          {
            effect = "deny"
            action = [
              "cam:AddQywxSubAccount",
              "cam:AddSubAccount",
              "cam:AddSubAccountCheckingMFA",
              "cam:AddUser",
              "cam:CreateSubAccounts"
            ]
            resource = ["*"]
          }
        ]
      })
    }

    deny-root-access-key = {
      policy_name = "DenyRootAccessKey"
      description = "Deny creating access keys for root user"
      content = jsonencode({
        version   = "2.0"
        statement = [
          {
            effect = "deny"
            action = [
              "cam:CreateAccessKey",
              "cam:CreateApiKey",
              "cam:CreateCollApiKey"
            ]
            resource = ["*"]
          }
        ]
      })
    }

    deny-public-db = {
      policy_name = "DenyPublicDbAccess"
      description = "Deny enabling public network access on DB instances"
      content = jsonencode({
        version   = "2.0"
        statement = [
          {
            effect = "deny"
            action = [
              "mongodb:EnableWanService",
              "redis:AllocateWanAddress",
              "cdb:OpenWanService",
              "postgres:OpenDBExtranetAccess"
            ]
            resource = ["*"]
          }
        ]
      })
    }


    deny-large-instance = {
      policy_name = "DenyLargeInstanceType"
      description = "Deny launching CVM instances with unapproved instance types"
      content = jsonencode({
        version   = "2.0"
        statement = [
          {
            effect   = "deny"
            action   = ["cvm:RunInstances"]
            resource = ["*"]
            condition = {
              string_not_equal = {
                "cvm:instance_type" = [
                  "S1.SMALL1",
                  "SA5.MEDIUM",
                  # TODO: add approved instance types
                ]
              }
            }
          }
        ]
      })
    }

    # NOTE: CBS actions use cvm: prefix in SCP (not cbs:)
    deny-snapshot-share = {
      policy_name = "DenySnapshotShare"
      description = "Deny modifying CBS snapshot share permission"
      content = jsonencode({
        version   = "2.0"
        statement = [
          {
            effect   = "deny"
            action   = ["cvm:ModifySnapshotsSharePermission"]
            resource = ["*"]
          }
        ]
      })
    }

    deny-image-share = {
      policy_name = "DenyImageShare"
      description = "Deny modifying CVM image share permission"
      content = jsonencode({
        version   = "2.0"
        statement = [
          {
            effect   = "deny"
            action   = ["cvm:ModifyImageSharePermission"]
            resource = ["*"]
          }
        ]
      })
    }

    mandatory-tags = {
      policy_name = "MandatoryTags"
      description = "Require mandatory tags on resource creation"
      content = jsonencode({
        version   = "2.0"
        statement = [
          {
            effect   = "allow"
            action   = ["cvm:RunInstances"]
            resource = "*"
            condition = {
              string_equal = {
                "qcs:request_tag/project" = "proj-a"
                # TODO: add more required tag key-value pairs
              }
            }
          }
        ]
      })
    }
  }
}

module "scp" {
  source   = "../../../modules/tco/tco-scp"
  for_each = local.policies

  policy_name  = each.value.policy_name
  type         = "SERVICE_CONTROL_POLICY"
  description  = each.value.description
  content      = each.value.content
  target_nodes = local.target_nodes
}
