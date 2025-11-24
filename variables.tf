variable "create_key" {
  description = "Whether to create a new SSH key or reference an existing one."
  type        = bool
  default     = true
}

variable "name" {
  description = "Name for the SSH key in Hetzner Cloud."
  type        = string
  default     = null

  validation {
    condition     = var.create_key ? (var.name != null && trimspace(var.name) != "") : true
    error_message = "Name must be provided when create_key is true."
  }
}

variable "public_key" {
  description = "Public key content in OpenSSH format. If null and create_key is true, a new key pair will be generated."
  type        = string
  default     = null
  sensitive   = true
}

variable "algorithm" {
  description = "Algorithm for generated key. Used only when public_key is null. Options: RSA, ECDSA, ED25519."
  type        = string
  default     = "ED25519"

  validation {
    condition     = contains(["RSA", "ECDSA", "ED25519"], var.algorithm)
    error_message = "Algorithm must be one of: RSA, ECDSA, ED25519."
  }
}

variable "rsa_bits" {
  description = "Number of bits for RSA key generation. Minimum 2048, recommended 4096."
  type        = number
  default     = 4096

  validation {
    condition     = var.rsa_bits >= 2048
    error_message = "RSA bits must be at least 2048."
  }
}

variable "ecdsa_curve" {
  description = "ECDSA curve for key generation. Options: P224, P256, P384, P521."
  type        = string
  default     = "P384"

  validation {
    condition     = contains(["P224", "P256", "P384", "P521"], var.ecdsa_curve)
    error_message = "ECDSA curve must be one of: P224, P256, P384, P521."
  }
}

variable "labels" {
  description = "Labels to apply to the SSH key."
  type        = map(string)
  default     = {}
}

variable "save_private_key_locally" {
  description = "Whether to save the generated private key to a local file. Only works when create_key is true and public_key is null."
  type        = bool
  default     = false
}

variable "local_key_directory" {
  description = "Directory where to save the private key file. Files will be named {name}.key and {name}.pub."
  type        = string
  default     = "."
}

variable "existing_key_id" {
  description = "ID of an existing SSH key to reference when create_key is false."
  type        = number
  default     = null

  validation {
    condition = (
      var.create_key ||
      var.existing_key_id != null ||
      (var.existing_key_name != null && trimspace(var.existing_key_name) != "")
    )
    error_message = "Provide either existing_key_id or existing_key_name when create_key is false."
  }
}

variable "existing_key_name" {
  description = "Name of an existing SSH key to reference when create_key is false."
  type        = string
  default     = null

  validation {
    condition     = var.existing_key_name == null || trimspace(var.existing_key_name) != ""
    error_message = "Existing key name must be non-empty when provided."
  }
}
