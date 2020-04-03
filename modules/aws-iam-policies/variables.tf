variable "aws_role_name" {
  type = string
  description = "IAM Role to which the policy will be attached"
}

variable "aws_account_id" {
  type = string
  description = "AWS account in which the cluster will be created"
}

variable "aws_emrfs_hbase_bucket_name" {
  type = string
  description = "AWS account in which the cluster will be created"
  default = ""
}

variable "aws_emrfs_hbase_logs_bucket_name" {
  type = string
  description = "AWS account in which the cluster will be created"
}

variable "aws_emrfs_hbase_logs_bucket_name" {
  type = string
  description = "AWS account in which the cluster will be created"
  default = ""
}

variable "aws_emrfs_spark_logs_bucket_name" {
  type = string
  description = "AWS account in which the cluster will be created"
  default = ""
}
