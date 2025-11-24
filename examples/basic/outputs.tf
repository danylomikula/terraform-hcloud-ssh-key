output "ssh_key_id" {
  description = "ID of the created SSH key."
  value       = module.ssh_key.ssh_key_id
  sensitive   = true
}

output "ssh_key_fingerprint" {
  description = "Fingerprint of the SSH key."
  value       = module.ssh_key.ssh_key_fingerprint
  sensitive   = true
}

output "public_key" {
  description = "Public key in OpenSSH format."
  value       = module.ssh_key.public_key_openssh
  sensitive   = true
}

output "private_key" {
  description = "Private key in OpenSSH format - save this securely."
  value       = module.ssh_key.private_key_openssh
  sensitive   = true
}

output "private_key_file" {
  description = "Path to the saved private key."
  value       = module.ssh_key.private_key_file_path
  sensitive   = true
}
