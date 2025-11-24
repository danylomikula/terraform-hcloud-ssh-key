resource "tls_private_key" "this" {
  count = var.create_key ? 1 : 0

  algorithm   = var.algorithm
  rsa_bits    = var.algorithm == "RSA" ? var.rsa_bits : null
  ecdsa_curve = var.algorithm == "ECDSA" ? var.ecdsa_curve : null
}

resource "hcloud_ssh_key" "this" {
  count = var.create_key ? 1 : 0

  name       = var.name
  public_key = var.public_key != null ? var.public_key : one(tls_private_key.this).public_key_openssh
  labels     = var.labels
}

data "hcloud_ssh_key" "existing_by_id" {
  count = var.create_key || var.existing_key_id == null ? 0 : 1
  id    = var.existing_key_id
}

data "hcloud_ssh_key" "existing_by_name" {
  count = var.create_key || var.existing_key_id != null || var.existing_key_name == null ? 0 : 1
  name  = var.existing_key_name
}

locals {
  created_key = var.create_key ? one(hcloud_ssh_key.this) : null
  existing_key = var.create_key ? null : (
    var.existing_key_id != null ? one(data.hcloud_ssh_key.existing_by_id) : one(data.hcloud_ssh_key.existing_by_name)
  )
  effective_key = var.create_key ? local.created_key : local.existing_key

  # Determine if we should save keys locally.
  should_save_locally = var.create_key && var.public_key == null && var.save_private_key_locally

  # Generate filename based on key name.
  private_key_filename = var.save_private_key_locally ? "${var.local_key_directory}/${var.name}.key" : ""
  public_key_filename  = var.save_private_key_locally ? "${var.local_key_directory}/${var.name}.pub" : ""
}

# Save private key locally if requested.
resource "local_sensitive_file" "private_key" {
  count = local.should_save_locally ? 1 : 0

  content         = one(tls_private_key.this).private_key_openssh
  filename        = local.private_key_filename
  file_permission = "0600"
}

# Save public key locally if requested.
resource "local_file" "public_key" {
  count = local.should_save_locally ? 1 : 0

  content         = one(tls_private_key.this).public_key_openssh
  filename        = local.public_key_filename
  file_permission = "0644"
}
