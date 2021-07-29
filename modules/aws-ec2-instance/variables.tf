variable "ami" {
  type        = string
  description = "The AMI to use for the EC2 instance"
}

variable "availability_zone" {
  type        = string
  description = "The availability zone to use for the EC2 instance"
  default     = "us-east-1a"
}

variable "iam_instance_profile" {
  type        = string
  description = "The iam instance profile to attach to the EC2 instance"
}

variable "instance_type" {
  type        = string
  description = "The instance type to use for the EC2 instance"
  default     = "c5.9xlarge"
}

variable "key_name" {
  type        = string
  description = "The key name to attach to the EC2 instance for SSH access"
}

variable "security_group_ids" {
  type        = list(string)
  description = "A list of security groups to attach to the EC2 instance"
}

variable "subnet_id" {
  type        = string
  description = "The subnet to create the EC2 instance in"
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

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources."
  default     = {}
}

variable "bootstrap_scripts" {
  type        = list(string)
  default     = []
  description = "List of body content of bootstrap shell scripts."
}
