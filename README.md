# Terraform Tamr EC2 Instance Template
This is a github repo for a terraform module to spin up an EC2 instance for Tamr, as well as additional dependencies.
This repo follows the [terraform standard module structure](https://www.terraform.io/docs/modules/index.html#standard-module-structure).

# Examples
## Basic
Inline example implementation of the module.  This is the most basic example of what it would look like to use this module.
```
module "basic" {
  source = "git::https://github.com/Datatamer/terraform-emr-tamr-vm?ref=0.2.0"
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
### IAM Policy
* `aws_role_name` (required): The IAM Role to attach the IAM policies to. By default sources from the IAM role created in this module.
* `aws_account_id` (required): The ARN of the AWS account where the cluster is created
* `aws_emrfs_hbase_bucket_name` (required): The name of the S3 bucket where HBase stores files.
* `aws_emrfs_hbase_logs_bucket_name` (required): The name of the S3 bucket where HBase stores logs.
* `aws_emrfs_spark_logs_bucket_name` (required): The name of the S3 bucket where Spark stores logs.
* `aws_emr_creator_policy_name` (optional): The name of the IAM policy giving EMR permissions. Defaults to `emrCreatorMinimalPolicy`.
* `aws_emrfs_user_policy_name` (optional): The name of the IAM policy giving S3 permissions. Defaults to  `emrfsUserMinimalPolicy`.

### IAM Role
* `aws_role_name` (optional): The name to give the IAM Role. Defaults to `tamr-instance-role`.
* `aws_instance_profile_name` (optional): The name to give to the IAM instance profile. Defaults to `tamr-instance-profile`.

### Security Group
* `vpc_id` (required): The ID of the VPC where the security group will be created.
* `sg_name` (optional): The name to give the new security group. Defaults to `tamr-instance-security-group`.
* `tamr_ui_port` (optional): The port that Tamr is using for UI access and API proxying. Defaults to `9100`.
* `tamr_es_port` (optional): The port that Tamr is using for UI access and API proxying. Defaults to `9200`.
* `tamr_auth_port` (optional): The port that Tamr is using for UI access and API proxying. Defaults to `9020`.
* `tamr_persistence_port` (optional): The port that Tamr is using for UI access and API proxying. Defaults to `9080`.
* `zk_port` (optional): Port for accessing Zookeeper on the Tamr instance. Defaults to `21281`
* `kibana_port` (optional): The port for Kibana acess. Defaults to `5601`.
* `enable_kibana_port` (optional): A boolean for whether to open the Kibana port. Defaults to `true`.
* `grafana_port` (optional): The port for Grafana acess. Defaults to `31101`.
* `enable_grafana_port` (optional): A boolean for whether to open the Grafana port. Defaults to `true`.
* `enable_ssh` (optional): A boolean for whether to enable SSH access on port `22`. Defaults to `true`.
* `enable_ping` (optional): A boolean for whether to enable ping using `ICMP`. Defaults to `true`.
* `ingress_cidr_blocks` (optional): A list of CIDR blocks to allow for inbound access. Defaults to `[]`, but must include a CIDR block that describes your VPC or local IP or Tamr will be inaccessible to you.
* `ingress_security_groups` (optional): A list of security groups to allow for inbound access. Defaults to `[]`.
* `egress_cidr_blocks` (optional): A list of CIDR blocks to allow for outbound access. Defaults to `["0.0.0.0/0"]` to allow services to talk to one another via the network loopback interface.
* `egress_security_groups` (optional): A list of security groups to allow for outbound access. Defaults to `[]`.
* `security_group_tags` (optional): Additional tags for the security. Defaults to `{Author :"Tamr"}`.

### EC2 Instance
* `ami` (required): The AMI to use to spin up the EC2 instance.
* `iam_instance_profile` (required): The iam instance profile to attach to the EC2 instance. Defaults to the instance profile created in this module.
* `key_name` (required): The SSH key to attach to the instance.
* `security_group_ids` (required): A list of security groups to attach to the instance. By default sources from the security group created in this module.
* `subnet_id` (required): The VPC Subnet ID to launch in.
* `availability_zone` (optional): The availability zone in which to place the EC2 instance. Defaults to `us-east-1`.
* `instance_type` (optional): The type of instance to use. Defaults to `c5.9xlarge`.
* `volume_type` (optional): What type of volume to attach to the instance. Defaults to `gp2`.
* `volume_size` (optional): How big of a volume to attach to the instance. Defaults to `100`.
* `tamr_instance_tags` (optional): Additional tags to attach to the instance created. Defaults to `{Author: "Tamr", Name: "Tamr VM"}`.

## Outputs
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
