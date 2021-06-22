variable "ports" {
  type        = list(number)
  description = "Ports used by the Tamr software"
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

variable "additional_ports" {
  type        = list(number)
  description = "Additional ports that should be added to the output of this module"
  default     = []
}
