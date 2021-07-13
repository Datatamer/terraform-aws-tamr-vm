variable "aws_emr_creator_policy_name" {
  type        = string
  description = "The name to give to the policy regarding EMR permissions"
  default     = "emrCreatorMinimalPolicy"
}

variable "aws_role_name" {
  type        = string
  description = "IAM Role to which the policy will be attached"
}

variable "s3_policy_arns" {
  type        = list(string)
  description = "List of S3 policy ARNs to attach to Tamr role."
}

variable "arn_partition" {
  type        = string
  description = <<EOF
  The partition in which the resource is located. A partition is a group of AWS Regions.
  Each AWS account is scoped to one partition.
  The following are the supported partitions:
    aws -AWS Regions
    aws-cn - China Regions
    aws-us-gov - AWS GovCloud (US) Regions
  EOF
  default     = "aws"
}

variable "tamr_emr_cluster_ids" {
  type        = list(string)
  description = "List of IDs for Static EMR clusters"
  default     = []
}

variable "tamr_emr_role_arns" {
  type        = list(string)
  description = "List of ARNs for EMR Service and EMR EC2 roles"
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources."
  default     = {}
}
