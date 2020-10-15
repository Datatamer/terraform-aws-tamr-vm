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

variable "tamr_ui_port" {
  type        = number
  description = "Port for Tamr UI and proxying Tamr services"
  default     = 9100
}

variable "tamr_es_port" {
  type        = number
  description = "Port for Tamr elasticsearch"
  default     = 9200
}

variable "tamr_auth_port" {
  type        = number
  description = "Port for Tamr auth"
  default     = 9020
}

variable "tamr_persistence_port" {
  type        = number
  description = "Port for Tamr persistence"
  default     = 9080
}

variable "zk_port" {
  type        = number
  description = "Port for accessing Zookeeper on the Tamr instance"
  default     = 21281
}

variable "kibana_port" {
  type        = number
  description = "Default Kibana port"
  default     = 5601
}

variable "enable_kibana_port" {
  type        = bool
  description = "If set to true, opens the kibana port for ingress"
  default     = true
}

variable "grafana_port" {
  type        = number
  description = "Default Grafana port"
  default     = 31101
}

variable "enable_grafana_port" {
  type        = bool
  description = "If set to true, opens the grafana port for ingress"
  default     = true
}

variable "enable_ssh" {
  type        = bool
  description = "If set to true, enables SSH"
  default     = true
}

variable "enable_ping" {
  type        = bool
  description = "If set to true, enables ping"
  default     = true
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
