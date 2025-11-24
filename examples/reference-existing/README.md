# Reference Existing Key Example

This example demonstrates how to reference existing SSH keys in Hetzner Cloud by name or ID without recreating them.

## Use cases

- Keys created manually through Hetzner Console
- Keys shared across multiple Terraform projects
- Avoid recreating keys that are already in use on servers
- Integrate existing infrastructure into Terraform management

## What it does

- References an existing SSH key by name (`ssh_key_by_name` module)
- References an existing SSH key by ID (`ssh_key_by_id` module)
- Does not create new keys, only retrieves existing ones

## Usage

First, find your existing key name or ID in the Hetzner Cloud Console.

```bash
export HCLOUD_TOKEN="your-api-token"
terraform init
terraform plan -var="existing_key_name=my-key" -var="existing_key_id=12345678"
terraform apply -var="existing_key_name=my-key" -var="existing_key_id=12345678"
```

Or create a `terraform.tfvars` file:

```hcl
existing_key_name = "my-key"
existing_key_id   = 12345678
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
| <a name="module_ssh_key_by_id"></a> [ssh\_key\_by\_id](#module\_ssh\_key\_by\_id) | ../.. | n/a |
| <a name="module_ssh_key_by_name"></a> [ssh\_key\_by\_name](#module\_ssh\_key\_by\_name) | ../.. | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_existing_key_id"></a> [existing\_key\_id](#input\_existing\_key\_id) | ID of an existing SSH key in Hetzner Cloud. | `number` | n/a | yes |
| <a name="input_existing_key_name"></a> [existing\_key\_name](#input\_existing\_key\_name) | Name of an existing SSH key in Hetzner Cloud. | `string` | n/a | yes |
| <a name="input_hcloud_token"></a> [hcloud\_token](#input\_hcloud\_token) | Hetzner Cloud API token. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_key_by_id"></a> [key\_by\_id](#output\_key\_by\_id) | SSH key details retrieved by ID. |
| <a name="output_key_by_name"></a> [key\_by\_name](#output\_key\_by\_name) | SSH key details retrieved by name. |
<!-- END_TF_DOCS -->
