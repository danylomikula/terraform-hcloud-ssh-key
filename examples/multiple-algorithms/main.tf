terraform {
  required_version = ">= 1.12.0"

  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = ">= 1.45.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.4.0"
    }
  }
}

provider "hcloud" {
  token = var.hcloud_token
}

# Generate ED25519 key (recommended for modern systems).
module "ssh_key_ed25519" {
  source = "../.."

  create_key = true
  name       = "example-ed25519"
  algorithm  = "ED25519"

  save_private_key_locally = true
  local_key_directory      = "${path.module}/keys"

  labels = {
    algorithm  = "ed25519"
    example    = "multiple-algorithms"
    managed_by = "terraform"
  }
}

# Generate RSA 4096 key (for legacy system compatibility).
module "ssh_key_rsa" {
  source = "../.."

  create_key = true
  name       = "example-rsa-4096"
  algorithm  = "RSA"
  rsa_bits   = 4096

  save_private_key_locally = true
  local_key_directory      = "${path.module}/keys"

  labels = {
    algorithm  = "rsa-4096"
    example    = "multiple-algorithms"
    managed_by = "terraform"
  }
}

# Generate ECDSA P384 key (balanced approach).
module "ssh_key_ecdsa" {
  source = "../.."

  create_key  = true
  name        = "example-ecdsa-p384"
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"

  save_private_key_locally = true
  local_key_directory      = "${path.module}/keys"

  labels = {
    algorithm  = "ecdsa-p384"
    example    = "multiple-algorithms"
    managed_by = "terraform"
  }
}
