# Tamr VM Terraform Module

## v4.4.3 - August 4th 2022
* Adjusts AWS provider constraints to allow newer versions

## v4.4.2 - February 15th 2022
* Updates version file to prevent the major upgrade to the AWS provider version 4.0.
* Updates examples to use the newest version of the s3-module.

## v4.4.1 - February 7th 2022
* Updates examples to use new versions of modules.

## v4.4.0 - December 20th 2021
* Deprecates `s3_policy_arns` in favor of `additional_policy_arns`.
* Allows the creation of the Cloudwatch log group and passes it to the shell script.

## v4.3.0 - December 17th 2021
* Adds `minimal-logs`example which allows the use of cloudwatch in an automated fashion.

## v4.2.0 - August 20th 2021
* Adds new variable `private_ips` to limit which private IPs can be assigned to the ENI attached to the Tamr EC2 Instance

## v4.1.0 - August 10th 2021
* Adds new variable `emr_abac_valid_tags` to be used in IAM Policies conditions for creating EMR Resources using ABAC

## v4.0.0 - July 30th 2021
* Adds tags to the EC2 instance's root EBS volume
* Adds network interface resource used as the default network interface on the EC2 instance in order to support tags
  (Major version note: Tamr VM recreates as a new taggable network interface is created and assigned at `device_index = 0`)

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
