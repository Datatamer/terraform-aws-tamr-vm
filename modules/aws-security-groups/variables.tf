variable "vpc_id" {
  type = string
  description = "The ID of the VPC in which to attach the security group"
}

variable "sg_name" {
  type = string
  description = "Security Group to create"
  default = "tamr-instance-security-group"
}

variable "tamr_ui_port" {
  type = number
  description = "Port for Tamr UI and proxying Tamr services"
  default = 9100
}

variable "tamr_es_port" {
  type = number
  description = "Port for Tamr elasticsearch"
  default = 9200
}

variable "tamr_auth_port" {
  type = number
  description = "Port for Tamr auth"
  default = 9020
}

variable "tamr_persistence_port" {
  type = number
  description = "Port for Tamr persistence"
  default = 9080
}

variable "zk_port" {
  type = number
  description = "Port for accessing Zookeeper on the Tamr instance"
  default = 21281
}

variable "kibana_port" {
  type = number
  description = "Default Kibana port"
  default = 5601
}

variable "enable_kibana_port" {
  type = bool
  description = "If set to true, opens the kibana port for ingress"
  default = true
}

variable "grafana_port" {
  type = number
  description = "Default Grafana port"
  default = 31101
}

variable "enable_grafana_port" {
  type = bool
  description = "If set to true, opens the grafana port for ingress"
  default = true
}

variable "enable_ssh" {
  type = bool
  description = "If set to true, enables SSH"
  default = true
}

variable "enable_ping" {
  type = bool
  description = "If set to true, enables ping"
  default = true
}

variable "ingress_cidr_blocks" {
  type = list(string)
  description = "CIDR blocks to attach to security groups for ingress"
  default = []
}

variable "egress_cidr_blocks" {
  type = list(string)
  description = "CIDR blocks to attach to security groups for egress"
  default = ["0.0.0.0/0"]
}

variable "additional_tags" {
  type = map(string)
  description = "Additional tags to be attached to the resources created"
  default = {Author :"Tamr"}
}
