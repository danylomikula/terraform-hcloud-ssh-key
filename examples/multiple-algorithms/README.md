# Multiple Algorithms Example

This example demonstrates how to generate SSH keys using different algorithms (ED25519, RSA, ECDSA) and compare their outputs.

## What it creates

- **ED25519 key** (`example-ed25519`) - Recommended for modern systems
- **RSA 4096 key** (`example-rsa-4096`) - For legacy system compatibility
- **ECDSA P384 key** (`example-ecdsa-p384`) - Balanced approach

All keys are saved locally in the `keys/` directory with appropriate labels.

## Algorithm comparison

| Algorithm | Security | Performance | Compatibility | Recommended Use |
|-----------|----------|-------------|---------------|-----------------|
| **ED25519** | High | Fast | Modern systems | Default choice |
| **RSA 4096** | High | Slower | All systems | Legacy compatibility |
| **ECDSA P384** | High | Fast | Most systems | Balanced approach |

## Usage

```bash
export HCLOUD_TOKEN="your-api-token"
terraform init
terraform plan
terraform apply
```

## Outputs

After applying, the keys will be saved in the `keys/` directory:

```
keys/
├── example-ed25519.key
├── example-ed25519.pub
├── example-rsa-4096.key
├── example-rsa-4096.pub
├── example-ecdsa-p384.key
└── example-ecdsa-p384.pub
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12.0 |
| <a name="requirement_hcloud"></a> [hcloud](#requirement\_hcloud) | >= 1.45.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 2.4.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 4.0.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ssh_key_ecdsa"></a> [ssh\_key\_ecdsa](#module\_ssh\_key\_ecdsa) | ../.. | n/a |
| <a name="module_ssh_key_ed25519"></a> [ssh\_key\_ed25519](#module\_ssh\_key\_ed25519) | ../.. | n/a |
| <a name="module_ssh_key_rsa"></a> [ssh\_key\_rsa](#module\_ssh\_key\_rsa) | ../.. | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_hcloud_token"></a> [hcloud\_token](#input\_hcloud\_token) | Hetzner Cloud API token. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_keys"></a> [keys](#output\_keys) | Details of all generated SSH keys. |
<!-- END_TF_DOCS -->
