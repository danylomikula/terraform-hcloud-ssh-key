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

# Reference existing key by name.
module "ssh_key_by_name" {
  source = "../.."

  create_key        = false
  existing_key_name = var.existing_key_name
}

# Reference existing key by ID (alternative approach).
module "ssh_key_by_id" {
  source = "../.."

  create_key      = false
  existing_key_id = var.existing_key_id
}
