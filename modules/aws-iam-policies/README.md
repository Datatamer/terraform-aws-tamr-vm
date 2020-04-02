# Tamr VM IAM Policies Module
This is a terraform module for creating a policy role in AWS with permissions to create a new EMR cluster.
This repo is laid out following the [terraform standard module structure](https://www.terraform.io/docs/modules/index.html#standard-module-structure).

# Examples
A minimal example implementation of the module is implemented in the examples folder.
This is the most basic example of what it would look like to use this module.
```
provider "aws" {
  version             = "2.45.0"
  region              = "us-east-1"
  allowed_account_ids = ["825693534638"]
}

provider "template" {
  version = "~> 2.1.2"
}

module "aws-emr-creator-iam" {
  source = "git::https://github.com/Datatamer/terraform-emr-tamr-vm/modules/aws-iam-policies?ref=0.1.0"
  aws_role_name = "iam-role-name"
  aws_account_id = "12-digit-ARN"
}
```

# Resources Created
This modules creates:
* an iam policy with permissions for creating a cluster
* an iam role policy attachment resource, to attach the newly created policy to an existing IAM role

# Variables
## Inputs
* `aws_role_name` (required) : The name of the existing IAM role that the policy will be attached to
* `aws_account_id` (required): The ARN of the AWS account where the cluster is created
* `aws_emrfs_hbase_bucket_name` (required): The name of the S3 bucket where HBase stores files.
* `aws_emrfs_hbase_logs_bucket_name` (required): The name of the S3 bucket where HBase stores logs.
* `aws_emrfs_spark_logs_bucket_name` (required): The name of the S3 bucket where Spark stores logs.


# References
This repo is based on:
* [terraform standard module structure](https://www.terraform.io/docs/modules/index.html#standard-module-structure)
* [templated terraform module](https://github.com/tmknom/template-terraform-module)

The permissions were scoped according to resource types as described in: https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonelasticmapreduce.html#amazonelasticmapreduce-cluster
* Minimal permissions were built based on Tamr user needs

# Development
## Releasing new versions
* Update version contained in `VERSION`
* Document changes in `CHANGELOG.md`
* Create a tag in github for the commit associated with the version

# License
Apache 2 Licensed. See LICENSE for full details.
