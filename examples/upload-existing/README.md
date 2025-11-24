# Upload Existing Key Example

This example demonstrates how to upload an existing public key to Hetzner Cloud.

## What it creates

- An SSH key named `uploaded-key` in Hetzner Cloud using your existing public key
- Labels for organization (`example=upload-existing`, `managed_by=terraform`)

## Usage

```bash
export HCLOUD_TOKEN="your-api-token"
terraform init
terraform plan -var="public_key=$(cat ~/.ssh/id_ed25519.pub)"
terraform apply -var="public_key=$(cat ~/.ssh/id_ed25519.pub)"
```

Or create a `terraform.tfvars` file:

```hcl
public_key = "ssh-ed25519 AAAA... your-email@example.com"
```

Then run:

```bash
export HCLOUD_TOKEN="your-api-token"
terraform init
terraform apply
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
| <a name="input_public_key"></a> [public\_key](#input\_public\_key) | Public key content in OpenSSH format. Example: TF\_VAR\_public\_key="$(cat ~/.ssh/id\_ed25519.pub)" | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ssh_key_fingerprint"></a> [ssh\_key\_fingerprint](#output\_ssh\_key\_fingerprint) | Fingerprint of the uploaded SSH key. |
| <a name="output_ssh_key_id"></a> [ssh\_key\_id](#output\_ssh\_key\_id) | ID of the uploaded SSH key. |
<!-- END_TF_DOCS -->
