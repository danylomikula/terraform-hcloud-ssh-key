output "key_by_name" {
  description = "SSH key details retrieved by name."
  value = {
    id          = module.ssh_key_by_name.ssh_key_id
    name        = module.ssh_key_by_name.ssh_key_name
    fingerprint = module.ssh_key_by_name.ssh_key_fingerprint
  }
}

output "key_by_id" {
  description = "SSH key details retrieved by ID."
  value = {
    id          = module.ssh_key_by_id.ssh_key_id
    name        = module.ssh_key_by_id.ssh_key_name
    fingerprint = module.ssh_key_by_id.ssh_key_fingerprint
  }
}
