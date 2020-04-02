variable "aws_role_name" {
    type = string
    description = "IAM Role to create"
    default = "tamr-instance-role"
}

variable "aws_instance_profile_name" {
    type = string
    description = "IAM Instance Profile to create"
    default = "tamr-instance-profile"
}
