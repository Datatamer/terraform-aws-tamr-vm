variable "aws_emr_creator_policy_name" {
  type        = string
  description = "The name to give to the policy regarding EMR permissions"
  default     = "emrCreatorMinimalPolicy"
}

variable "aws_role_name" {
  type        = string
  description = "IAM Role to create, and to which the policies will be attached"
}

variable "aws_instance_profile_name" {
  type        = string
  description = "IAM Instance Profile to create"
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

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC in which to attach the security group"
}

variable "ami" {
  type        = string
  description = "The AMI to use for the EC2 instance"
}

variable "availability_zone" {
  type        = string
  description = "The availability zone to use for the EC2 instance"
  default     = "us-east-1a"
}

variable "instance_type" {
  type        = string
  description = "The instance type to use for the EC2 instance"
  default     = "c5.9xlarge"
}

variable "volume_type" {
  type        = string
  description = "The type of root block volume to attach to the EC2 instance"
  default     = "gp2"
}

variable "volume_size" {
  type        = number
  description = "The size of the root block volume to attach to the EC2 instance"
  default     = 100
}

variable "enable_volume_encryption" {
  type        = bool
  description = "Whether to encrypt the root block device"
  default     = true
}

variable "tamr_instance_tags" {
  type        = map(string)
  description = "Additional tags to be attached to the Tamr EC2 instance"
  default     = { Author : "Tamr", Name : "Tamr VM" }
}

variable "key_name" {
  type        = string
  description = "The key name to attach to the EC2 instance for SSH access"
}

variable "sg_name" {
  type        = string
  description = "Security Group to create"
  default     = "tamr-instance-security-group"
}

variable "subnet_id" {
  type        = string
  description = "The subnet to create the EC2 instance in"
}

variable "ports" {
  type        = list(number)
  description = "Destination ports to create network rules for"
  default = [
    22,
    9100,  // UI
    9200,  // ES
    9020,  // auth
    9080,  // persistence
    21281, // zookeeper
    5601,  // kibana
    31101, // grafana
  ]
}

variable "ingress_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks to attach to security groups for ingress"
  default     = []
}

variable "ingress_security_groups" {
  type        = list(string)
  description = "Existing security groups to attch to new security groups for ingress"
  default     = []
}

variable "egress_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks to attach to security groups for egress"
  default     = []
}

variable "egress_security_groups" {
  type        = list(string)
  description = "Existing security groups to attch to new security groups for egress"
  default     = []
}

variable "security_group_tags" {
  type        = map(string)
  description = "Additional tags to be attached to the security group created"
  default     = { Author : "Tamr" }
}

variable "bootstrap_scripts" {
  type        = list(string)
  default     = []
  description = "List of body content of bootstrap shell scripts."
}
