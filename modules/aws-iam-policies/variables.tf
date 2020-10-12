variable "aws_emr_creator_policy_name" {
  type        = string
  description = "The name to give to the policy regarding EMR permissions"
  default     = "emrCreatorMinimalPolicy"
}

variable "aws_emrfs_user_policy_name" {
  type        = string
  description = "The name to give to the policy regarding S3 permissions"
  default     = "emrfsUserMinimalPolicy"
}

variable "aws_role_name" {
  type        = string
  description = "IAM Role to which the policy will be attached"
}

variable "aws_emrfs_hbase_bucket_name" {
  type        = string
  description = "Name of HBase root directory S3 bucket"
}

variable "aws_emrfs_hbase_logs_bucket_name" {
  type        = string
  description = "Name of HBase logs S3 bucket"
}

variable "aws_emrfs_spark_logs_bucket_name" {
  type        = string
  description = "Name of Spark logs S3 bucket"
}
