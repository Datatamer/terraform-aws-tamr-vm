variable "vpc_id" {
  type        = string
  description = "The ID of the VPC in which to attach the security group"
}

variable "sg_name" {
  type        = string
  description = "Security Group to create"
  default     = "tamr-instance-security-group"
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
  description = "Existing security groups to attach to new security groups for egress"
  default     = []
}

variable "additional_tags" {
  type        = map(string)
  description = "Additional tags to be attached to the resources created"
  default     = { Author : "Tamr" }
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

variable "maximum_rules_per_sg" {
  type        = number
  description = "Maximum number of rules for each security group"
  default     = 50
}
