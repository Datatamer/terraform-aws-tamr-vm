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
  default = ""
}

variable "aws_emrfs_spark_logs_bucket_name" {
  type = string
  description = "AWS account in which the cluster will be created"
  default = ""
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

variable "key_name" {
  type = string
  description = "The key name to attach to the EC2 instance for SSH access"
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
