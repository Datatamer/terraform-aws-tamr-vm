# Tamr VM Terraform Module

## v3.2.0 - July 12nd 2021
* Adds new variable `tags` to set tags for all resources
* Deprecates `additional_tags` in favor of `tags`

## v3.1.0 - July 6th 2021
*  Adds new variable `permissions_boundary` to set the permissions boundary for the IAM Role used by the Tamr EC2 Instance

## v3.0.0 - July 1st 2021
* Update to policy to remove wildcards wherever possible
* New configuration variables:
  * `tamr_emr_cluster_ids`
  * `tamr_emr_role_arns`

## v2.0.0 - June 22nd 2021
* Nested security group module refactored to only return the list of ingress ports instead of creating the security groups
* Output changed from `tamr_security_group_id` to `security_group_ids`
* New input variables for the main module:
  * `security_group_ids`
* Removed input variables from the main module:
  * `ingress_cidr_blocks`
  * `ingress_security_groups`
  * `egress_cidr_blocks`
  * `egress_security_groups`
  * `ports`
  * `security_group_tags`
  * `sg_name`
* New input variables for the security group module:
  * `additional_ports`
* Removed input variables from the security group module:
  * `*_port`
  * `additional_tags`
  * `ingress_cidr_blocks`
  * `ingress_security_groups`
  * `egress_cidr_blocks`
  * `egress_security_groups`
  * `enable_*`
  * `sg_name`
  * `vpc_id`

## v1.0.2 - April 27th 2021
* Upgrades and pins `terraform-aws-modules/key-pair/aws` to version 1.0.0

## v1.0.1 - April 16th 2021
* Fixes a bug where policy does not attach if you taint the module
* Simplifies example by creating fewer buckets and adding a 'name-prefix' variable

## v1.0.0 - April 12th 2021
* Updates minimum Terraform version to 13
* Updates minimum AWS provider version to 3.36.0

## v0.6.0 - April 7th 2021
*  Adds new variable `arn_partition` to set the partition of any ARNs referenced in this module

## v0.5.0 - January 13th 2021
* Adds ability to pass in `bootstrap_scripts` that will run during the boot cycle when you first launch an instance.
* Adds example usage of `bootstrap_scripts`

## v0.4.0 - October 15th 2020
* Removes input variables `aws_emrfs_hbase_bucket_name`, `aws_emrfs_hbase_logs_bucket_name`, `aws_emrfs_spark_logs_bucket_name`, and `aws_emrfs_user_policy_name`
  * Modifies minimal example accordingly to show dependency on [terraform-aws-s3](https://github.com/Datatamer/terraform-aws-s3) module for creating S3 buckets and S3 IAM policies

## v0.3.1 - October 13th 2020
* Add `enable_volume_encryption` input variable for encrypting root block device

## v0.3.0 - October 12th 2020
* Removes `aws_account_id` input variable
* Updates minimal example to create required resources
* Adds `s3_policy_arns` input variable to pass S3 bucket access policies to Tamr user IAM role.

## v0.2.2 - July 6th 2020
* Adds ListObjects to the s3 policy

## v0.2.1 - June 11th 2020
* Updates the policy to support both static and ephemeral EMR clusters

## v0.1.0 - March 23rd 2020
* Initing project
* Create role policy with minimal permissions needed to spin up an EMR cluster and submit jobs, S3 permissions for primary and backup filesystem
* Resource to attach role policy to existing user (assumption that IAM role already exists)
  * Policies can be locked down by specifying the ARN for which permission is granted
* Create security groups for Tamr instance running on AWS EC2. Rules are attached using the security group rules resource
* Create IAM role for Tamr instance running on AWS EC2
* Create EC2 instance with attached roles and security groups
