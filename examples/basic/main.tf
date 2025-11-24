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

module "ssh_key" {
  source = "../.."

  create_key = true
  name       = "example-key"
  algorithm  = "ED25519"

  # Automatically save keys locally.
  save_private_key_locally = true
  local_key_directory      = path.module

  labels = {
    example    = "basic"
    managed_by = "terraform"
  }
}
