terraform {
  required_version = ">= 1.12.0"

  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = ">= 1.45.0"
    }
  }
}

provider "hcloud" {
  token = var.hcloud_token
}

locals {
  # Team members configuration with local paths
  team_members = {
    alice = {
      public_key_path = "${path.module}/team-members/alice.pub"
      role            = "admin"
    }
    bob = {
      public_key_path = "${path.module}/team-members/bob.pub"
      role            = "developer"
    }
    carol = {
      public_key_path = "${path.module}/team-members/carol.pub"
      role            = "developer"
    }
  }
}

# Upload multiple team member keys using for_each.
module "team_keys" {
  source = "../.."

  for_each = local.team_members

  create_key = true
  name       = "team-${each.key}"
  public_key = file(each.value.public_key_path)

  labels = {
    team       = "devops"
    member     = each.key
    role       = each.value.role
    managed_by = "terraform"
  }
}
