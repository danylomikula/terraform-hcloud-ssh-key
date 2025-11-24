output "ssh_key_id" {
  description = "ID of the uploaded SSH key."
  value       = module.ssh_key.ssh_key_id
  sensitive   = true
}

output "ssh_key_fingerprint" {
  description = "Fingerprint of the uploaded SSH key."
  value       = module.ssh_key.ssh_key_fingerprint
  sensitive   = true
}
