variable "aws_role_name" {
    type = string
    description = "IAM Role to which the policy will be attached"
}

variable "aws_account_id" {
    type = string
    description = "AWS account in which the cluster will be created"
}
