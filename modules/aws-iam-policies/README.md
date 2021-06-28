# Tamr VM IAM Policies Module
This terraform modules creates a policy role in AWS with permissions to create a new EMR cluster.

# Examples
## Basic
Inline example implementation of the module.  This is the most basic example of what it would look like to use this module.
```
module "aws-emr-creator-iam" {
  source         = "git::https://github.com/Datatamer/terraform-aws-tamr-vm.git//modules/aws-iam-policies?ref=1.0.0"
  aws_role_name  = "iam-role-name"
  s3_policy_arns = [
    arn:aws:iam::aws:policy/HBaseRootDirReadWrite,
    arn:aws:iam::aws:policy/HBaseLogsReadWrite,
    arn:aws:iam::aws:policy/SparkLogsReadWrite
  ]
}
```

# Resources Created
This modules creates:
* an IAM policy with permissions for creating a cluster
* an IAM role policy attachment resource, to attach the newly created policy to an existing IAM role

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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_role\_name | IAM Role to which the policy will be attached | `string` | n/a | yes |
| s3\_policy\_arns | List of S3 policy ARNs to attach to Tamr role. | `list(string)` | n/a | yes |
| arn\_partition | The partition in which the resource is located. A partition is a group of AWS Regions.<br>  Each AWS account is scoped to one partition.<br>  The following are the supported partitions:<br>    aws -AWS Regions<br>    aws-cn - China Regions<br>    aws-us-gov - AWS GovCloud (US) Regions | `string` | `"aws"` | no |
| aws\_emr\_creator\_policy\_name | The name to give to the policy regarding EMR permissions | `string` | `"emrCreatorMinimalPolicy"` | no |
| tamr\_emr\_cluster\_ids | List of IDs for Static EMR clusters | `list(string)` | `[]` | no |
| tamr\_emr\_role\_arns | List of ARNs for EMR Service and EMR EC2 roles | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| emr\_creator\_policy\_arn | ARN of the EMR creator IAM policy created. |
| s3\_policy\_arns | List of ARNs of S3 policies attached to Tamr user IAM role |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# References
This repo is based on:
* [EMR Permissions](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonelasticmapreduce.html#amazonelasticmapreduce-cluster)

# License
Apache 2 Licensed. See LICENSE for full details.
