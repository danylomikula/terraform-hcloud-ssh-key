output "team_keys" {
  description = "Details of all team SSH keys."
  value = {
    for name, key in module.team_keys : name => {
      id          = key.ssh_key_id
      fingerprint = key.ssh_key_fingerprint
      labels      = key.ssh_key_labels
    }
  }
  sensitive = true
}

output "all_key_ids" {
  description = "List of all team SSH key IDs for use with server module."
  value       = [for key in module.team_keys : key.ssh_key_id]
  sensitive   = true
}
