# Terraform Tamr EC2 Instance Template
This is a github repo for a terraform module to spin up an EC2 instance for Tamr, as well as additional dependencies.
This repo follows the [terraform standard module structure](https://www.terraform.io/docs/modules/index.html#standard-module-structure).

# Examples
## Basic
Inline example implementation of the module.  This is the most basic example of what it would look like to use this module.
```
module "basic" {
  source = "git::https://github.com/Datatamer/terraform-emr-tamr-vm?ref=0.1.0"
  aws_role_name = "name-for-tamr-role"
  aws_instance_profile_name = "name-for-tamr-instance-profile"
  aws_account_id = "123456789012"
  aws_emrfs_hbase_bucket_name = "hbase-root-bucket-name"
  aws_emrfs_hbase_logs_bucket_name = "hbase-logs-bucket-name"
  aws_emrfs_spark_logs_bucket_name = "spark-logs-bucket-name"
  vpc_id = "vpc-12345abcde"
  ami = "ami-abcde12345"
  key_name = "ssh-key-name"
  subnet_id = "subnet-123456789"
  ingress_cidr_blocks = [
    "1.2.3.4/16"
  ]
}
```
An additional example is available in the `examples` folder.

# Resources Created
This modules creates:
* an EC2 instance with attached roles and security groups in order to run Tamr and EMR
* an iam policy with permissions for creating a cluster
* an iam role policy attachment resource, to attach the newly created policy to an existing IAM role
* an IAM role for use by the Tamr VM
* a security group for EC2 allowing access to the Tamr VM.
* additonal security group rules. By default, opens required Tamr ports,
enables HTTP on port `80` and TLS on `443`, and opens egress, which allows Tamr to operate and recreates
AWS's default ALLOW ALL egress rules. These ports can be changed if desired. Additional
ports for basic monitoring (Kibana and Grafana), as well as SSH, and ping,
can be enabled using boolean variables. Additional rules can be added manually.

# Variables
## Inputs
* `aws_role_name` (required): The IAM Role to attach the IAM policies to.
* `aws_instance_profile_name` (required): The name to give to the IAM instance profile.
* `aws_account_id` (required): The ARN of the AWS account where the cluster is created
* `aws_emrfs_hbase_bucket_name` (required): The name of the S3 bucket where HBase stores files.
* `aws_emrfs_hbase_logs_bucket_name` (required): The name of the S3 bucket where HBase stores logs.
* `aws_emrfs_spark_logs_bucket_name` (required): The name of the S3 bucket where Spark stores logs.
* `vpc_id` (required): The ID of the VPC where the security group will be created.
* `subnet_id` (required): The VPC Subnet ID to launch in.
* `ami` (required): The AMI to use to spin up the EC2 instance.
* `key_name` (required): The SSH key to attach to the instance.
* `ingress_cidr_blocks` (optional): A list of CIDR blocks to allow for inbound access. Defaults to `[]`, but must include a CIDR block that describes your VPC or local IP or Tamr will be inaccessible to you.
* `sg_name` (optional): The name to give the new security group. Defaults to `tamr-instance-security-group`.
* `aws_emr_creator_policy_name` (optional): The name of the IAM policy giving EMR permissions. Defaults to `emrCreatorMinimalPolicy`.
* `aws_emrfs_user_policy_name` (optional): The name of the IAM policy giving S3 permissions. Defaults to `emrfsUserMinimalPolicy`.

## Outputs
Write your Terraform module outputs.
* `tamr_security_group_id`: The ID of the security group created by the `aws-security-group` submodule, and that is attached to the Tamr EC2 instance.
* `tamr_instance_ip`: The private IP address of the Tamr instance.

# References
This repo is based on:
* [terraform standard module structure](https://www.terraform.io/docs/modules/index.html#standard-module-structure)
* [templated terraform module](https://github.com/tmknom/template-terraform-module)

# Development
## Releasing new versions
* Update version contained in `VERSION`
* Document changes in `CHANGELOG.md`
* Create a tag in github for the commit associated with the version

# License
Apache 2 Licensed. See LICENSE for full details.
