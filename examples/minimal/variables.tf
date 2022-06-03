variable "ami_id" {
  type        = string
  description = "AMI to use for Tamr EC2 instance"
}

variable "name-prefix" {
  type        = string
  description = "A string to prepend to names of resources created by this example"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources created by this example."
  default = {
    Author      = "Tamr"
    Environment = "Example"
  }
}

variable "tamr_instance_tags" {
  type        = map(string)
  description = "A map of tags to add to the EC2 resource created by this example."
  default = {
    Author      = "Tamr"
    Environment = "Example"
  }
}

variable "vpc_cidr_block" {
  type = string
}

variable "vm_subnet_cidr_block" {
  type = string
}

variable "install_script_path" {
  type = string
  default = "./test-bootstrap-scripts/install-pip.sh"
}

variable "check_install_script_path" {
  type = string
  default = "./test-bootstrap-scripts/check-install.sh"
}