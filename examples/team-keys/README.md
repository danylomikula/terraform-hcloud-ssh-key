# Team Keys Example

This example demonstrates how to manage multiple team member SSH keys using `for_each` and labels.

## What it creates

- SSH keys for each team member (alice, bob, carol)
- Labels for organization:
  - `team` - Team name (devops)
  - `member` - Team member name
  - `role` - Member role (admin/developer)
  - `managed_by` - Terraform

## Team structure

| Member | Role | Key File |
|--------|------|----------|
| alice | admin | `team-members/alice.pub` |
| bob | developer | `team-members/bob.pub` |
| carol | developer | `team-members/carol.pub` |

## Usage

1. Add team member public keys to `team-members/` directory
2. Update `locals` in `main.tf` if needed
3. Apply the configuration:

```bash
export HCLOUD_TOKEN="your-api-token"
terraform init
terraform plan
terraform apply
```

## Adding new team members

1. Add the public key file to `team-members/` directory
2. Update `locals.team_members` in `main.tf`:

```hcl
locals {
  team_members = {
    # ... existing members ...
    dave = {
      public_key_path = "${path.module}/team-members/dave.pub"
      role            = "developer"
    }
  }
}
```

3. Run `terraform apply`

## Removing team members

1. Remove the entry from `locals.team_members`
2. Run `terraform apply`
3. Optionally remove the public key file

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
| <a name="module_team_keys"></a> [team\_keys](#module\_team\_keys) | ../.. | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_hcloud_token"></a> [hcloud\_token](#input\_hcloud\_token) | Hetzner Cloud API token. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_all_key_ids"></a> [all\_key\_ids](#output\_all\_key\_ids) | List of all team SSH key IDs for use with server module. |
| <a name="output_team_keys"></a> [team\_keys](#output\_team\_keys) | Details of all team SSH keys. |
<!-- END_TF_DOCS -->
