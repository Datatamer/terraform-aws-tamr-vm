# Tamr User IAM Role Module
This is a terraform module for an IAM role for the EC2 instance where Tamr is running. This role will have permissions attached to it using the`aws-emr-tamr-user-policies` module.
This repo is layed out following the [terraform standard module structure](https://www.terraform.io/docs/modules/index.html#standard-module-structure).

# Examples
An inline example implementation of the module is implemented in the examples folder.
This is the most basic example of what it would look like to use this module.

```
module "aws-tamr-user-role" {
  source = "git::https://github.com/Datatamer/aws-emr-tamr-user-role?ref=0.1.0"
  aws_role_name = "iam-role-name"
}
```

# Resources Created
This modules creates:
* an IAM role for use by the Tamr VM

# Variables
## Inputs
* `aws_role_name` (optional): The name to give the IAM Role. Defaults to `tamr-instance-role`

## Outputs
* `tamr_instance_profile_id`: ID for the IAM instance profile created.

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
