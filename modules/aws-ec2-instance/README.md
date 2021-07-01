# Tamr EMR Creator Permissions Module
This terraform module creates an EC2 instance on which Tamr will run.

# Examples
## Basic
Inline example implementation of the module.  This is the most basic example of what it would look like to use this module.
```
module "aws-tamr-instance" {
  source               = "git::https://github.com/Datatamer/terraform-aws-tamr-vm.git//modules/aws-ec2-instance?ref=x.y.z"
  ami                  = "ami-123456789"
  iam_instance_profile = "iam-profile-id"
  key_name             = "my-key"
  security_group_ids   = ["security-group-1-id", "security-group-2-id"]
  subnet_id            = "subnet-123"
}
```

# Resources Created
This module creates:
* an EC2 instance with attached roles and security groups in order to run Tamr and EMR

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| aws | >= 2.45.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.45.0 |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ami | The AMI to use for the EC2 instance | `string` | n/a | yes |
| iam\_instance\_profile | The iam instance profile to attach to the EC2 instance | `string` | n/a | yes |
| key\_name | The key name to attach to the EC2 instance for SSH access | `string` | n/a | yes |
| security\_group\_ids | A list of security groups to attach to the EC2 instance | `list(string)` | n/a | yes |
| subnet\_id | The subnet to create the EC2 instance in | `string` | n/a | yes |
| additional\_tags | Additional tags to be attached to the resources created | `map(string)` | <pre>{<br>  "Author": "Tamr",<br>  "Name": "Tamr VM"<br>}</pre> | no |
| availability\_zone | The availability zone to use for the EC2 instance | `string` | `"us-east-1a"` | no |
| bootstrap\_scripts | List of body content of bootstrap shell scripts. | `list(string)` | `[]` | no |
| enable\_volume\_encryption | Whether to encrypt the root block device | `bool` | `true` | no |
| instance\_type | The instance type to use for the EC2 instance | `string` | `"c5.9xlarge"` | no |
| volume\_size | The size of the root block volume to attach to the EC2 instance | `number` | `100` | no |
| volume\_type | The type of root block volume to attach to the EC2 instance | `string` | `"gp2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| bootstrap\_scripts | The final rendered multi-part cloud-init config. |
| ec2\_instance\_id | The ID of the instance created |
| tamr\_instance\_ip | The private IP address of the EC2 instance created |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# References
This repo is based on:
* [terraform standard module structure](https://www.terraform.io/docs/modules/index.html#standard-module-structure)
* [templated terraform module](https://github.com/tmknom/template-terraform-module)

# License
Apache 2 Licensed. See LICENSE for full details.
