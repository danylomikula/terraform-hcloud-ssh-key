output "keys" {
  description = "Details of all generated SSH keys."
  value = {
    ed25519 = {
      id               = module.ssh_key_ed25519.ssh_key_id
      name             = module.ssh_key_ed25519.ssh_key_name
      fingerprint      = module.ssh_key_ed25519.ssh_key_fingerprint
      private_key_path = module.ssh_key_ed25519.private_key_file_path
    }
    rsa_4096 = {
      id               = module.ssh_key_rsa.ssh_key_id
      name             = module.ssh_key_rsa.ssh_key_name
      fingerprint      = module.ssh_key_rsa.ssh_key_fingerprint
      private_key_path = module.ssh_key_rsa.private_key_file_path
    }
    ecdsa_p384 = {
      id               = module.ssh_key_ecdsa.ssh_key_id
      name             = module.ssh_key_ecdsa.ssh_key_name
      fingerprint      = module.ssh_key_ecdsa.ssh_key_fingerprint
      private_key_path = module.ssh_key_ecdsa.private_key_file_path
    }
  }
  sensitive = true
}
