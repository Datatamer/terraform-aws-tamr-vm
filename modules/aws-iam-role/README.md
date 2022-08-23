# Tamr User IAM Role Module
This Terraform module creates an IAM role for the EC2 instance where Tamr is running. This role will have permissions attached to it using the [aws-emr-tamr-user-policies](https://github.com/Datatamer/ops/tree/master/terraform/shared_files/modules/aws-emr-tamr-user-policies) module.

# Resources Created
This modules creates:
* an IAM role for use by the Tamr VM

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | >= 3.36, !=4.0.0, !=4.1.0, !=4.2.0, !=4.3.0, !=4.4.0, !=4.5.0, !=4.6.0, !=4.7.0, !=4.8.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.36, !=4.0.0, !=4.1.0, !=4.2.0, !=4.3.0, !=4.4.0, !=4.5.0, !=4.6.0, !=4.7.0, !=4.8.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_instance\_profile\_name | IAM Instance Profile to create | `string` | `"tamr-instance-profile"` | no |
| aws\_role\_name | IAM Role to create | `string` | `"tamr-instance-role"` | no |
| permissions\_boundary | ARN of the policy that will be used to set the permissions boundary for the IAM Role | `string` | `null` | no |
| tags | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| tamr\_instance\_profile\_id | ID of the IAM instance profile created |
| tamr\_instance\_role\_name | ID of the role created |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# References
This repo is based on:
* [terraform standard module structure](https://www.terraform.io/docs/modules/index.html#standard-module-structure)
* [templated terraform module](https://github.com/tmknom/template-terraform-module)

# License
Apache 2 Licensed. See LICENSE for full details.
