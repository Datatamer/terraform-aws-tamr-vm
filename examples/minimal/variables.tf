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
  description = "Additional tags for resources created by this example"
  default     = { 
    Author = "Tamr"
    Environment = "Example"
  }
}
