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

variable "ingress_protocol" {
  type        = string
  description = "Protocol for ingress rules. If not icmp, icmpv6, tcp, udp, or all use the protocol number."
}

variable "egress_protocol" {
  type        = string
  description = "Protocol for egress rules. If not icmp, icmpv6, tcp, udp, or all use the protocol number."
}

variable "key_name" {
  type        = string
  description = "The key pair name."
}

variable "log_group" {
  type        = string
  description = "The Cloudwatch log group name."
}

variable "log_stream" {
  type        = string
  description = "The Cloudwatch log stream name."
}
