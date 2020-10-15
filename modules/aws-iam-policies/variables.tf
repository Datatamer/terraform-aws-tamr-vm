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
