variable "hcloud_token" {
  description = "Hetzner Cloud API token."
  type        = string
  sensitive   = true
}

variable "existing_key_name" {
  description = "Name of an existing SSH key in Hetzner Cloud."
  type        = string
}

variable "existing_key_id" {
  description = "ID of an existing SSH key in Hetzner Cloud."
  type        = number
}
