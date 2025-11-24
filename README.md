# Hetzner Cloud SSH Key Terraform Module

[![Release](https://img.shields.io/github/v/release/danylomikula/terraform-hcloud-ssh-key)](https://github.com/danylomikula/terraform-hcloud-ssh-key/releases)
[![Pre-Commit](https://github.com/danylomikula/terraform-hcloud-ssh-key/actions/workflows/pre-commit.yml/badge.svg)](https://github.com/danylomikula/terraform-hcloud-ssh-key/actions/workflows/pre-commit.yml)
[![License](https://img.shields.io/github/license/danylomikula/terraform-hcloud-ssh-key)](https://github.com/danylomikula/terraform-hcloud-ssh-key/blob/main/LICENSE)

Terraform module for managing SSH keys in Hetzner Cloud with optional automated key pair generation.

## Features

- **Automated Key Generation**: Creates ED25519, RSA, or ECDSA key pairs using Terraform's TLS provider
- **Automatic Local Save**: Optionally save generated keys to local files with intuitive naming
- **Bring Your Own Key**: Upload existing public keys to Hetzner Cloud
- **Reuse Existing Keys**: Reference keys already in Hetzner Cloud by ID or name
- **Secure Outputs**: Private keys are marked as sensitive
- **Flexible Labels**: Organize keys with custom labels

## Usage

### Generate New ED25519 SSH Key (Recommended)

ED25519 is the recommended algorithm for new keys - it's fast, secure, and has small key sizes.

```hcl
module "ssh_key_ed25519" {
  source = "danylomikula/ssh-key/hcloud"

  create_key = true
  name       = "production-key"
  algorithm  = "ED25519"

  # Automatically save keys to local files
  save_private_key_locally = true
  local_key_directory      = "~/.ssh"  # Saves as ~/.ssh/production-key.key and ~/.ssh/production-key.pub

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }
}

# Use the saved key immediately
output "ssh_command" {
  value = "ssh -i ${module.ssh_key_ed25519.private_key_file_path} root@server-ip"
}
```

### Generate RSA SSH Key

RSA keys offer wider compatibility with older systems.

```hcl
module "ssh_key_rsa" {
  source = "danylomikula/ssh-key/hcloud"

  create_key = true
  name       = "legacy-system-key"
  algorithm  = "RSA"
  rsa_bits   = 4096  # 4096 bits for enhanced security

  save_private_key_locally = true
  local_key_directory      = "./keys"

  labels = {
    purpose    = "legacy-systems"
    managed_by = "terraform"
  }
}
```

### Generate ECDSA SSH Key

ECDSA provides a balance between security and performance.

```hcl
module "ssh_key_ecdsa" {
  source = "danylomikula/ssh-key/hcloud"

  create_key = true
  name       = "ecdsa-key"
  algorithm  = "ECDSA"
  ecdsa_curve = "P384"  # Options: P224, P256, P384, P521

  save_private_key_locally = true
  local_key_directory      = "./keys"

  labels = {
    algorithm  = "ecdsa"
    managed_by = "terraform"
  }
}
```

### Upload Existing Public Key

If you already have SSH keys generated outside Terraform, you can upload just the public key.

```hcl
module "ssh_key_existing" {
  source = "danylomikula/ssh-key/hcloud"

  create_key = true
  name       = "my-existing-key"
  public_key = file("~/.ssh/id_ed25519.pub")

  labels = {
    source     = "external"
    managed_by = "terraform"
  }
}
```

### Upload Multiple Existing Keys

```hcl
# Upload team member keys
module "ssh_keys_team" {
  source = "danylomikula/ssh-key/hcloud"

  for_each = {
    alice = "~/.ssh/team/alice.pub"
    bob   = "~/.ssh/team/bob.pub"
    carol = "~/.ssh/team/carol.pub"
  }

  create_key = true
  name       = "team-${each.key}"
  public_key = file(each.value)

  labels = {
    team       = "devops"
    member     = each.key
    managed_by = "terraform"
  }
}
```

### Reference Existing Hetzner Cloud Key by Name

**Use case**: You already have SSH keys in Hetzner Cloud and want to reference them in Terraform without recreating.

**Why use this**:
- Keys created manually through Hetzner Console
- Keys shared across multiple Terraform projects
- Avoid recreating keys that are already in use on servers
- Integrate existing infrastructure into Terraform management

```hcl
module "ssh_key_reference" {
  source = "danylomikula/ssh-key/hcloud"

  create_key        = false
  existing_key_name = "my-existing-key"
}

# Use in server module
module "server" {
  source = "danylomikula/server/hcloud"

  servers = {
    web = {
      server_type = "cx23"
      location    = "nbg1"
      ssh_keys    = [module.ssh_key_reference.ssh_key_id]
    }
  }
}
```

### Reference Existing Hetzner Cloud Key by ID

```hcl
module "ssh_key_by_id" {
  source = "danylomikula/ssh-key/hcloud"

  create_key      = false
  existing_key_id = 12345678
}
```

### Using with hcloud_server Resource

```hcl
module "ssh_key" {
  source = "danylomikula/ssh-key/hcloud"

  create_key = true
  name       = "web-server-key"
  algorithm  = "ED25519"

  save_private_key_locally = true
  local_key_directory      = "./keys"
}

resource "hcloud_server" "web" {
  name        = "web-server"
  server_type = "cx22"
  location    = "nbg1"
  image       = "ubuntu-24.04"
  ssh_keys    = [module.ssh_key.ssh_key_name]
}

output "ssh_command" {
  value = "ssh -i ${module.ssh_key.private_key_file_path} root@${hcloud_server.web.ipv4_address}"
}
```

## Examples

| Directory | Description |
|-----------|-------------|
| [basic](./examples/basic) | Generate new ED25519 key pair with automatic local save |
| [upload-existing](./examples/upload-existing) | Upload an existing public key to Hetzner Cloud |
| [reference-existing](./examples/reference-existing) | Reference existing Hetzner Cloud keys by name or ID without recreating |
| [multiple-algorithms](./examples/multiple-algorithms) | Generate and compare ED25519, RSA, and ECDSA keys |
| [team-keys](./examples/team-keys) | Manage multiple team member SSH keys with for_each and labels |

## Supported Algorithms

| Algorithm | Security | Performance | Compatibility | Recommended Use |
|-----------|----------|-------------|---------------|-----------------|
| **ED25519** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | Modern systems (default) |
| **RSA 4096** | ⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | Legacy systems |
| **ECDSA P384** | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ | Balanced approach |

**Recommendation**: Use ED25519 unless you need compatibility with older systems that don't support it.

## Security Considerations

- **State Security**: Private keys are marked as `sensitive = true` in Terraform outputs
- **State Encryption**: Always enable Terraform state encryption (S3 with KMS, Terraform Cloud, etc.)
- **Secret Management**: Consider external secret management solutions (HashiCorp Vault, AWS Secrets Manager)
- **Key Rotation**: Rotate SSH keys regularly according to your security policy
- **File Permissions**: Generated key files are created with 0600 permissions automatically
- **Gitignore**: Add `*.key` and `*.pub` to `.gitignore` to prevent accidental commits
- **Backup**: Securely backup private keys before destroying Terraform state

## Best Practices

1. **Generate keys in Terraform** rather than uploading for full lifecycle management
2. **Save keys locally** during initial provisioning, then store securely in a vault
3. **Use labels** to organize keys by environment, team, or purpose
4. **Reference existing keys** when sharing across multiple projects
5. **Use ED25519** for new deployments unless compatibility is a concern

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12.0 |
| <a name="requirement_hcloud"></a> [hcloud](#requirement\_hcloud) | >= 1.45.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 2.4.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 4.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_hcloud"></a> [hcloud](#provider\_hcloud) | >= 1.45.0 |
| <a name="provider_local"></a> [local](#provider\_local) | >= 2.4.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | >= 4.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [hcloud_ssh_key.this](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/ssh_key) | resource |
| [local_file.public_key](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_sensitive_file.private_key](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |
| [tls_private_key.this](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [hcloud_ssh_key.existing_by_id](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/data-sources/ssh_key) | data source |
| [hcloud_ssh_key.existing_by_name](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/data-sources/ssh_key) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_algorithm"></a> [algorithm](#input\_algorithm) | Algorithm for generated key. Used only when public\_key is null. Options: RSA, ECDSA, ED25519. | `string` | `"ED25519"` | no |
| <a name="input_create_key"></a> [create\_key](#input\_create\_key) | Whether to create a new SSH key or reference an existing one. | `bool` | `true` | no |
| <a name="input_ecdsa_curve"></a> [ecdsa\_curve](#input\_ecdsa\_curve) | ECDSA curve for key generation. Options: P224, P256, P384, P521. | `string` | `"P384"` | no |
| <a name="input_existing_key_id"></a> [existing\_key\_id](#input\_existing\_key\_id) | ID of an existing SSH key to reference when create\_key is false. | `number` | `null` | no |
| <a name="input_existing_key_name"></a> [existing\_key\_name](#input\_existing\_key\_name) | Name of an existing SSH key to reference when create\_key is false. | `string` | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels to apply to the SSH key. | `map(string)` | `{}` | no |
| <a name="input_local_key_directory"></a> [local\_key\_directory](#input\_local\_key\_directory) | Directory where to save the private key file. Files will be named {name}.key and {name}.pub. | `string` | `"."` | no |
| <a name="input_name"></a> [name](#input\_name) | Name for the SSH key in Hetzner Cloud. | `string` | `null` | no |
| <a name="input_public_key"></a> [public\_key](#input\_public\_key) | Public key content in OpenSSH format. If null and create\_key is true, a new key pair will be generated. | `string` | `null` | no |
| <a name="input_rsa_bits"></a> [rsa\_bits](#input\_rsa\_bits) | Number of bits for RSA key generation. Minimum 2048, recommended 4096. | `number` | `4096` | no |
| <a name="input_save_private_key_locally"></a> [save\_private\_key\_locally](#input\_save\_private\_key\_locally) | Whether to save the generated private key to a local file. Only works when create\_key is true and public\_key is null. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_key_file_path"></a> [private\_key\_file\_path](#output\_private\_key\_file\_path) | Path to the saved private key file. Only available when save\_private\_key\_locally is true. |
| <a name="output_private_key_openssh"></a> [private\_key\_openssh](#output\_private\_key\_openssh) | Private key in OpenSSH format. Only available when key was generated by this module. |
| <a name="output_private_key_pem"></a> [private\_key\_pem](#output\_private\_key\_pem) | Private key in PEM format. Only available when key was generated by this module. |
| <a name="output_public_key_file_path"></a> [public\_key\_file\_path](#output\_public\_key\_file\_path) | Path to the saved public key file. Only available when save\_private\_key\_locally is true. |
| <a name="output_public_key_openssh"></a> [public\_key\_openssh](#output\_public\_key\_openssh) | Public key in OpenSSH format. |
| <a name="output_ssh_key_fingerprint"></a> [ssh\_key\_fingerprint](#output\_ssh\_key\_fingerprint) | Fingerprint of the SSH key. |
| <a name="output_ssh_key_id"></a> [ssh\_key\_id](#output\_ssh\_key\_id) | ID of the Hetzner Cloud SSH key. |
| <a name="output_ssh_key_labels"></a> [ssh\_key\_labels](#output\_ssh\_key\_labels) | Labels applied to the SSH key. |
| <a name="output_ssh_key_name"></a> [ssh\_key\_name](#output\_ssh\_key\_name) | Name of the SSH key. |
<!-- END_TF_DOCS -->

## Related Modules

| Module | Description | GitHub | Terraform Registry |
|--------|-------------|--------|-------------------|
| **terraform-hcloud-network** | Manage Hetzner Cloud networks and subnets | [GitHub](https://github.com/danylomikula/terraform-hcloud-network) | [Registry](https://registry.terraform.io/modules/danylomikula/network/hcloud) |
| **terraform-hcloud-firewall** | Manage Hetzner Cloud firewalls | [GitHub](https://github.com/danylomikula/terraform-hcloud-firewall) | [Registry](https://registry.terraform.io/modules/danylomikula/firewall/hcloud) |
| **terraform-hcloud-server** | Manage Hetzner Cloud servers | [GitHub](https://github.com/danylomikula/terraform-hcloud-server) | [Registry](https://registry.terraform.io/modules/danylomikula/server/hcloud) |

## Authors

Module managed by [Danylo Mikula](https://github.com/danylomikula).

## Contributing

Contributions are welcome! Please read the [Contributing Guide](.github/contributing.md) for details on the process and commit conventions.

## License

Apache 2.0 Licensed. See [LICENSE](LICENSE) for full details.
