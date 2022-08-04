variable "name-prefix" {
  type        = string
  description = "A string to prepend to names of resources created by this example"
}

variable "name_tag" {
  type        = string
  description = "A string to apply as the VM Name Tag"
}

variable "vpc_cidr_block" {
  type = string
}

variable "vm_subnet_cidr_block" {
  type = string
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources created by this example."
  default     = {}
}

variable "install_script_path" {
  type = string
}

variable "check_install_script_path" {
  type = string
}
