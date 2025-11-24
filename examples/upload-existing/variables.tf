variable "hcloud_token" {
  description = "Hetzner Cloud API token."
  type        = string
  sensitive   = true
}

variable "public_key" {
  description = "Public key content in OpenSSH format. Example: TF_VAR_public_key=\"$(cat ~/.ssh/id_ed25519.pub)\""
  type        = string
  sensitive   = true
}
