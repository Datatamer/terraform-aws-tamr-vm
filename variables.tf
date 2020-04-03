variable "aws_emr_creator_policy_name" {
  type = string
  description = "The name to give to the policy regarding EMR permissions"
  default = "emrCreatorMinimalPolicy"
}

variable "aws_emrfs_user_policy_name" {
  type = string
  description = "The name to give to the policy regarding S3 permissions"
  default = "emrfsUserMinimalPolicy"
}

variable "aws_role_name" {
  type = string
  description = "IAM Role to create, and to which the policies will be attached"
}

variable "aws_instance_profile_name" {
  type = string
  description = "IAM Instance Profile to create"
}

variable "aws_account_id" {
  type = string
  description = "AWS account in which the cluster will be created"
}

variable "aws_emrfs_hbase_bucket_name" {
  type = string
  description = "AWS account in which the cluster will be created"
}

variable "aws_emrfs_hbase_logs_bucket_name" {
  type = string
  description = "AWS account in which the cluster will be created"
}

variable "aws_emrfs_spark_logs_bucket_name" {
  type = string
  description = "AWS account in which the cluster will be created"
}

variable "vpc_id" {
  type = string
  description = "The ID of the VPC in which to attach the security group"
}

variable "ami" {
  type = string
  description = "The AMI to use for the EC2 instance"
}

variable "instance_type" {
  type = string
  description = "The instance type to use for the EC2 instance"
  default = "c5.9xlarge"
}

variable "tamr_instance_tags" {
  type = map(string)
  description = "Additional tags to be attached to the Tamr EC2 instance"
  default = (
    {Author :"Tamr"},
    {Name: "Tamr VM"},
  )
}

variable "key_name" {
  type = string
  description = "The key name to attach to the EC2 instance for SSH access"
}

variable "sg_name" {
  type = string
  description = "Security Group to create"
  default = "tamr-instance-security-group"
}

variable "subnet_id" {
  type = string
  description = "The subnet to create the EC2 instance in"
}

variable "ingress_cidr_blocks" {
  type = list(string)
  description = "CIDR blocks to attach to security groups for ingress"
  default = []
}

variable "security_group_tags" {
  type = map(string)
  description = "Additional tags to be attached to the security group created"
  default = {Author :"Tamr"}
}
