terraform {
  required_version = ">= 1.13.0"

  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = ">= 1.62.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.2.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.8.0"
    }
  }
}
