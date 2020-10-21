# Terraform AWS Tamr EC2 Instance Template
This terraform module spins up an EC2 instance for Tamr, as well as additional dependencies.

# Examples
## Basic
Inline example implementation of the module.  This is the most basic example of what it would look like to use this module.
```
module "basic" {
source                           = "git::https://github.com/Datatamer/terraform-aws-tamr-vm?ref=0.5.0"
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
* a security group for EC2 allowing access to the Tamr VM.
* additonal security group rules. By default, opens required Tamr ports,
enables HTTP on port `80` and TLS on `443`, and opens egress, which allows Tamr to operate and recreates
AWS's default ALLOW ALL egress rules. These ports can be changed if desired. Additional
ports for basic monitoring (Kibana and Grafana), as well as SSH, and ping,
can be enabled using boolean variables. Additional rules can be added manually.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| aws | >= 2.45.0 |

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ami | The AMI to use for the EC2 instance | `string` | n/a | yes |
| name\_prefix | A prefix to add to the names of all created resources | `string` | n/a | yes |
| s3\_policy\_arns | List of S3 policy ARNs to attach to Tamr role. | `list(string)` | n/a | yes |
| subnet\_id | The subnet to create the EC2 instance in | `string` | n/a | yes |
| vpc\_id | The ID of the VPC in which to attach the security group | `string` | n/a | yes |
| availability\_zone | The availability zone to use for the EC2 instance | `string` | `"us-east-1a"` | no |
| egress\_cidr\_blocks | CIDR blocks to attach to security groups for egress | `list(string)` | `[]` | no |
| egress\_security\_groups | Existing security groups to attch to new security groups for egress | `list(string)` | `[]` | no |
| enable\_grafana\_port | If set to true, opens the grafana port for ingress | `bool` | `true` | no |
| enable\_kibana\_port | If set to true, opens the kibana port for ingress | `bool` | `true` | no |
| enable\_ping | If set to true, enables ping | `bool` | `true` | no |
| enable\_ssh | If set to true, enables SSH | `bool` | `true` | no |
| enable\_volume\_encryption | Whether to encrypt the root block device | `bool` | `true` | no |
| grafana\_port | Default Grafana port | `number` | `31101` | no |
| ingress\_cidr\_blocks | CIDR blocks to attach to security groups for ingress | `list(string)` | `[]` | no |
| ingress\_security\_groups | Existing security groups to attch to new security groups for ingress | `list(string)` | `[]` | no |
| instance\_type | The instance type to use for the EC2 instance | `string` | `"c5.9xlarge"` | no |
| kibana\_port | Default Kibana port | `number` | `5601` | no |
| security\_group\_tags | Additional tags to be attached to the security group created | `map(string)` | <pre>{<br>  "Author": "Tamr"<br>}</pre> | no |
| tamr\_auth\_port | Port for Tamr auth | `number` | `9020` | no |
| tamr\_es\_port | Port for Tamr elasticsearch | `number` | `9200` | no |
| tamr\_instance\_tags | Additional tags to be attached to the Tamr EC2 instance | `map(string)` | <pre>{<br>  "Author": "Tamr",<br>  "Name": "Tamr VM"<br>}</pre> | no |
| tamr\_persistence\_port | Port for Tamr persistence | `number` | `9080` | no |
| tamr\_ui\_port | Port for Tamr UI and proxying Tamr services | `number` | `9100` | no |
| volume\_size | The size of the root block volume to attach to the EC2 instance | `number` | `100` | no |
| volume\_type | The type of root block volume to attach to the EC2 instance | `string` | `"gp2"` | no |
| zk\_port | Port for accessing Zookeeper on the Tamr instance | `number` | `21281` | no |

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
