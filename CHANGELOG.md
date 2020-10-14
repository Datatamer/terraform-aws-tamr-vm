# Tamr VM Terraform Module

## v0.3.2 - October 14th 2020
* Removes `aws_emrfs_user_policy_name` input variable
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
