# Tamr User IAM Role Module
This is a terraform module for an IAM role for the EC2 instance where Tamr is running. This role will have permissions attached to it using the`aws-emr-tamr-user-policies` module.
This repo is laid out following the [terraform standard module structure](https://www.terraform.io/docs/modules/index.html#standard-module-structure).

# Examples
An inline example implementation of the module is implemented in the examples folder.
This is the most basic example of what it would look like to use this module.

```
module "aws-tamr-user-role" {
  source = "git::https://github.com/Datatamer/terraform-aws-tamr-vm/modules/aws-iam-role?ref=0.2.2"
  aws_role_name = "iam-role-name"
}
```

# Resources Created
This modules creates:
* an IAM role for use by the Tamr VM

# Variables
## Inputs
* `aws_role_name` (optional): The name to give the IAM Role. Defaults to `tamr-instance-role`.
* `aws_instance_profile_name` (optional): The name to give to the IAM instance profile. Defaults to `tamr-instance-profile`.

## Outputs
* `tamr_instance_profile_id`: ID for the IAM instance profile created.
* `tamr_instance_role_name`: The name of the IAM instance role created.

# References
This repo is based on:
* [terraform standard module structure](https://www.terraform.io/docs/modules/index.html#standard-module-structure)
* [templated terraform module](https://github.com/tmknom/template-terraform-module)

# License
Apache 2 Licensed. See LICENSE for full details.
