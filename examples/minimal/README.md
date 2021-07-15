<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| tls | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ami\_id | AMI to use for Tamr EC2 instance | `string` | n/a | yes |
| name-prefix | A string to prepend to names of resources created by this example | `string` | n/a | yes |
| tags | A map of tags to add to all resources created by this example. | `map(string)` | <pre>{<br>  "Author": "Tamr",<br>  "Environment": "Example"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| subnet\_id | n/a |
| tamr\_key\_pair\_name | Name of EC2 key pair created for Tamr instance |
| tamr\_private\_key | n/a |
| tamr\_vm | n/a |
| vpc\_id | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
