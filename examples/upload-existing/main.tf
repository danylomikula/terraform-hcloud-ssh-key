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
  name       = "uploaded-key"
  public_key = var.public_key

  labels = {
    example    = "upload-existing"
    managed_by = "terraform"
  }
}
