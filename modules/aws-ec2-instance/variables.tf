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

variable "private_ips" {
  type        = list(string)
  description = "List of private IPs to assign to the ENI attached to the Tamr EC2 Instance"
  default     = null
}

variable "require_http_tokens" {
  type        = bool
  description = "Whether to enable IMDSv2 on the Tamr EC2 Instance"
  default     = true
}

#
# Startup Script
#
variable "tamr_config_file" {
  type        = string
  description = "Override generated tamr configuration. The tamr configuration is specified using a yaml file, in the format that is documented (https://docs.tamr.com/previous/docs/configuration-configuring-unify#section-setting-configuration-variables) for configuring “many variables” at once."
}

variable "pre_install_bash" {
  default     = ""
  type        = string
  description = <<EOF
  Bash to be run before Tamr is installed.
  Likely to be used to meet Tamr's prerequisites, if not already met by the image. (https://docs.tamr.com/new/docs/requirements )
   This will only be run once before Tamr is installed, unless Tamr fails to install. This bash will also be run on subsequent attempts to install Tamr, so it is recommended that this bash is idempotent.
  EOF
}

variable "tamr_zip_uri" {
  type        = string
  description = "gcs location to download tamr zip from"
}

variable "tamr_instance_install_directory" {
  # Get it?, DataTamer :p
  default     = "/data/tamr"
  type        = string
  description = "directory to install tamr into"
}

#
# file system
#
variable "tamr_filesystem_bucket" {
  type        = string
  description = "S3 bucket to use for the tamr default file system"
}

