# Cloudwatch log collection Example
The following example will deploy the necessary resources to:
- Download the Cloudwatch agent.
- Install the Cloudwatch agent.
- Create and mount the configuration file.
- Enable the Cloudwatch agent.

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
| egress\_protocol | Protocol for egress rules. If not icmp, icmpv6, tcp, udp, or all use the protocol number. | `string` | n/a | yes |
| ingress\_protocol | Protocol for ingress rules. If not icmp, icmpv6, tcp, udp, or all use the protocol number. | `string` | n/a | yes |
| key\_name | The key pair name. | `string` | n/a | yes |
| log\_group | The Cloudwatch log group name. | `string` | n/a | yes |
| log\_stream | The Cloudwatch log stream name. | `string` | n/a | yes |
| name-prefix | A string to prepend to names of resources created by this example | `string` | n/a | yes |
| tags | A map of tags to add to all resources created by this example. | `map(string)` | <pre>{<br>  "Author": "Tamr",<br>  "Environment": "Example"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| application\_subnet\_id | n/a |
| tamr\_private\_key | n/a |
| tamr\_vm | n/a |
| vpc\_id | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
