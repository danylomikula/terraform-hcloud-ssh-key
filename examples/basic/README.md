# Basic Example

This example demonstrates how to generate a new ED25519 SSH key pair and automatically save it locally.

## What it creates

- An SSH key named `example-key` in Hetzner Cloud
- ED25519 key pair (recommended algorithm)
- Private key saved locally as `example-key.key`
- Public key saved locally as `example-key.pub`
- Labels for organization (`example=basic`, `managed_by=terraform`)

## Usage

```bash
export HCLOUD_TOKEN="your-api-token"
terraform init
terraform plan
terraform apply
```

## Outputs

After applying, you can use the generated key:

```bash
ssh -i example-key.key root@your-server-ip
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12.0 |
| <a name="requirement_hcloud"></a> [hcloud](#requirement\_hcloud) | >= 1.45.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ssh_key"></a> [ssh\_key](#module\_ssh\_key) | ../.. | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_hcloud_token"></a> [hcloud\_token](#input\_hcloud\_token) | Hetzner Cloud API token. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_key"></a> [private\_key](#output\_private\_key) | Private key in OpenSSH format - save this securely. |
| <a name="output_private_key_file"></a> [private\_key\_file](#output\_private\_key\_file) | Path to the saved private key. |
| <a name="output_public_key"></a> [public\_key](#output\_public\_key) | Public key in OpenSSH format. |
| <a name="output_ssh_key_fingerprint"></a> [ssh\_key\_fingerprint](#output\_ssh\_key\_fingerprint) | Fingerprint of the SSH key. |
| <a name="output_ssh_key_id"></a> [ssh\_key\_id](#output\_ssh\_key\_id) | ID of the created SSH key. |
<!-- END_TF_DOCS -->
