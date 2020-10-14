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

## Outputs

| Name | Description |
|------|-------------|
| emr\_creator\_policy\_arn | ARN of the EMR creator IAM policy created. |
| s3\_policy\_arns | List of ARNs of S3 policies attached to Tamr user IAM role |
| subnet\_id | n/a |
| tamr\_instance\_id | The ID of the Tamr instance created |
| tamr\_instance\_ip | Private IP address of the Tamr instance |
| tamr\_instance\_profile\_id | ID of the IAM instance profile created |
| tamr\_instance\_role\_name | ID of the Tamr user IAM role created |
| tamr\_key\_pair\_name | Name of EC2 key pair created for Tamr instance |
| tamr\_security\_group\_id | ID of the security group created |
| vpc\_id | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
