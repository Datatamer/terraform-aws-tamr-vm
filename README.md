# Terraform AWS Tamr EC2 Instance Template
This terraform module spins up an EC2 instance for Tamr, as well as additional dependencies.

# Examples
## Basic
Inline example implementation of the module.  This is the most basic example of what it would look like to use this module.
```
module "basic" {
source                           = "git::https://github.com/Datatamer/terraform-aws-tamr-vm?ref=x.y.z"
  aws_role_name                    = "name-for-tamr-role"
  aws_instance_profile_name        = "name-for-tamr-instance-profile"
  s3_policy_arns = [
    arn:aws:iam::aws:policy/HBaseRootDirReadWrite,
    arn:aws:iam::aws:policy/HBaseLogsReadWrite,
    arn:aws:iam::aws:policy/SparkLogsReadWrite
  ]
  vpc_id                           = "vpc-12345abcde"
  ami                              = "ami-abcde12345"
  key_name                         = "ssh-key-name"
  subnet_id                        = "subnet-123456789"
  ingress_cidr_blocks = [
    "1.2.3.4/16"
  ]
  egress_cidr_blocks  = [
    "0.0.0.0/0"
  ]
}
```
## Minimal
Smallest complete fully working example. This example might require extra resources to run the example.
- [Minimal](https://github.com/Datatamer/terraform-aws-tamr-vm/tree/master/examples/minimal)

# Resources Created
This modules creates:
* an EC2 instance with attached roles and security groups in order to run Tamr and EMR
* an IAM policy with permissions for creating a cluster
* an IAM role policy attachment resource, to attach the newly created policy to an existing IAM role
* an IAM role for use by the Tamr VM

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | >= 3.36.0 |

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_policy\_arns | List of policy ARNs to be attached to Tamr VM IAM role. | `list(string)` | n/a | yes |
| ami | The AMI to use for the EC2 instance | `string` | n/a | yes |
| aws\_instance\_profile\_name | IAM Instance Profile to create | `string` | n/a | yes |
| aws\_role\_name | IAM Role to create, and to which the policies will be attached | `string` | n/a | yes |
| key\_name | The key name to attach to the EC2 instance for SSH access | `string` | n/a | yes |
| subnet\_id | The subnet to create the EC2 instance in | `string` | n/a | yes |
| vpc\_id | The ID of the VPC in which to attach the security group | `string` | n/a | yes |
| arn\_partition | The partition in which the resource is located. A partition is a group of AWS Regions.<br>  Each AWS account is scoped to one partition.<br>  The following are the supported partitions:<br>    aws -AWS Regions<br>    aws-cn - China Regions<br>    aws-us-gov - AWS GovCloud (US) Regions | `string` | `"aws"` | no |
| availability\_zone | The availability zone to use for the EC2 instance | `string` | `"us-east-1a"` | no |
| aws\_emr\_creator\_policy\_name | The name to give to the policy regarding EMR permissions | `string` | `"emrCreatorMinimalPolicy"` | no |
| bootstrap\_scripts | List of body content of bootstrap shell scripts. | `list(string)` | `[]` | no |
| emr\_abac\_valid\_tags | A map of valid tags for maintaining EMR resources when using ABAC IAM Policies with Tag Conditions. Make sure your tamr-config.yml file specifies tags key values. Refer to tamr-config module examples for more info. | `map(list(string))` | `{}` | no |
| enable\_volume\_encryption | Whether to encrypt the root block device | `bool` | `true` | no |
| instance\_type | The instance type to use for the EC2 instance | `string` | `"c5.9xlarge"` | no |
| permissions\_boundary | ARN of the policy that will be used to set the permissions boundary for the IAM Role | `string` | `null` | no |
| private\_ips | List of private IPs to assign to the ENI attached to the Tamr EC2 Instance | `list(string)` | `null` | no |
| s3\_policy\_arns | [DEPRECATED] List of S3 policy ARNs to attach to Tamr role. | `list(string)` | `[]` | no |
| security\_group\_ids | Security groups to associate with the ec2 instance | `list(string)` | `[]` | no |
| tags | A map of tags to add to all resources. | `map(string)` | `{}` | no |
| tamr\_emr\_cluster\_ids | List of IDs for Static EMR clusters | `list(string)` | `[]` | no |
| tamr\_emr\_role\_arns | List of ARNs for EMR Service and EMR EC2 roles | `list(string)` | `[]` | no |
| tamr\_instance\_tags | Additional tags to be attached to the Tamr EC2 instance | `map(string)` | <pre>{<br>  "Author": "Tamr",<br>  "Name": "Tamr VM"<br>}</pre> | no |
| volume\_size | The size of the root block volume to attach to the EC2 instance | `number` | `100` | no |
| volume\_type | The type of root block volume to attach to the EC2 instance | `string` | `"gp2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| tamr\_iam\_policies | n/a |
| tamr\_iam\_role | n/a |
| tamr\_instance | n/a |
| tamr\_security\_groups | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# References
This repo is based on:
* [terraform standard module structure](https://www.terraform.io/docs/modules/index.html#standard-module-structure)
* [templated terraform module](https://github.com/tmknom/template-terraform-module)
* [User Data AWS Docs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html)

# Development
## Generating Docs
Run `make terraform/docs` to generate the section of docs around terraform inputs, outputs and requirements.

## Checkstyles
Run `make lint`, this will run terraform fmt, in addition to a few other checks to detect whitespace issues.
NOTE: this requires having docker working on the machine running the test

## Releasing new versions
* Update version contained in `VERSION`
* Document changes in `CHANGELOG.md`
* Create a tag in github for the commit associated with the version

# License
Apache 2 Licensed. See LICENSE for full details.
