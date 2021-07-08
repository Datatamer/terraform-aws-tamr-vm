variable "aws_role_name" {
  type        = string
  description = "IAM Role to create"
  default     = "tamr-instance-role"
}

variable "aws_instance_profile_name" {
  type        = string
  description = "IAM Instance Profile to create"
  default     = "tamr-instance-profile"
}

variable "permissions_boundary" {
  type        = string
  description = "ARN of the policy that will be used to set the permissions boundary for the IAM Role"
  default     = null
}

variable "additional_tags" {
  type        = map(string)
  description = "Additional tags to be attached to the IAM resources created"
  default     = {}
}
