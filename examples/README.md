# Examples

This directory contains examples demonstrating how to use the Hetzner Cloud SSH Key module.

## Available Examples

| Example | Description |
|---------|-------------|
| [basic](./basic/) | Generate a new ED25519 SSH key pair with automatic local save |
| [upload-existing](./upload-existing/) | Upload an existing public key to Hetzner Cloud |
| [reference-existing](./reference-existing/) | Reference existing Hetzner Cloud keys by name or ID without recreating |
| [multiple-algorithms](./multiple-algorithms/) | Generate and compare ED25519, RSA, and ECDSA keys |
| [team-keys](./team-keys/) | Manage multiple team member SSH keys with for_each and labels |

## Usage

Each example can be run independently:

```bash
cd examples/basic
export HCLOUD_TOKEN="your-api-token"
terraform init
terraform apply
```
