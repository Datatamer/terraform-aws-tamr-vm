# EMR Creator Permissions Module
This is a terraform module for an EC2 instance on which Tamr will run.
This repo is laid out following the [terraform standard module structure](https://www.terraform.io/docs/modules/index.html#standard-module-structure).

# Examples
An inline example implementation of the module is implemented in the examples folder.
This is the most basic example of what it would look like to use this module.

```
module "aws-tamr-instance" {
  source = "git::https://github.com/Datatamer/terraform-emr-tamr-vm/modules/aws-ec2-instance?ref=0.1.0"
  ami = "ami-123456789"
  iam_instance_profile = "iam-profile-id"
  key_name = "my-key"
  security_group_ids = ["security-group-1-id", "security-group-2-id"]
  subnet_id = "subnet-123"
}
```

# Resources Created
This modules creates:
* an EC2 instance with attached roles and security groups in order to run Tamr and EMR

# Variables
## Inputs
* `ami` (required): The AMI to use to spin up the EC2 instance.
* `availability_zone` (optional): The availability zone in which to place the instance. Defaults to `us-east-1`.
* `iam_instance_profile` (required): The iam instance profile to attach to the EC2 instance.
* `instance_type` (optional): The type of instance to use. Defaults to `c5.9xlarge`.
* `key_name` (required): The SSH key to attach to the instance.
* `security_group_ids` (required): A list of security groups to attach to the instance.
* `subnet_id` (required): The VPC Subnet ID to launch in.
* `volume_type` (optional): What type of volume to attach to the instance, if attaching a root block volume. Defaults to `gp2`.
* `volume_size` (optional): How big of a volume to attach to the instance, if attaching a root block volume. Defaults to `100`.
* `additional_tags` (optional): Additional tags to attach to the instance created


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
