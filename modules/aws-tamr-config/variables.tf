variable "config_template_path" {
  type        = string
  description = "Path to Tamr config template."
  default     = "./tamr-config.yml"
}

#
# Populated with terraform-aws-rds-postgres module outputs
#
variable "rds_pg_hostname" {
  type        = string
  description = "Host name for the RDS postgres instance"
}

variable "rds_pg_dbname" {
  type        = string
  description = "RDS postgres database name"
}

variable "rds_pg_username" {
  type        = string
  description = "Username for the RDS postgres database instance"
}

variable "rds_pg_password" {
  type        = string
  description = "Password for the RDS postgres database instance"
}

#
# Populated with terraform-aws-s3 module outputs
#
variable "root_directory_bucket_name" {
  type        = string
  description = "Name of Tamr root directory bucket."
}

variable "logs_bucket_name" {
  type        = string
  description = "Name of Tamr logs bucket."
}

#
# Populated with terraform-aws-emr module outputs
#
variable "emr_cluster_name" {
  type        = string
  description = "Name of EMR cluster"
}

variable "emr_cluster_id" {
  type        = string
  description = "EMR cluster ID"
}

#
# Populated with terraform-aws-es module outputs (if applicable)
#
variable "es_domain_endpoint" {
  type        = string
  description = "Endpoint of Elasticsearch domain"
  default     = ""
}

#
# Other inputs
#
variable "tamr_hbase_namespace" {
  type = string
}

variable "tamr_spark_driver_memory" {
  type    = string
  default = "5G"
}

variable "tamr_spark_executor_instances" {
  type    = number
  default = 2
}

variable "tamr_spark_executor_memory" {
  type    = string
  default = "8G"
}

variable "tamr_spark_executor_cores" {
  type    = number
  default = 2
}

variable "tamr_spark_properties_override" {
  type        = string
  description = "JSON blob of spark properties to override. If not set, will use a default set of properties that should work for most use cases"
  default     = ""
}

variable "tamr_external_storage_providers" {
  type        = string
  description = "Filesystem connection information for external storage providers."
  default     = ""
}

variable "additional_templated_variables" {
  type        = map(string)
  description = "Map of variable name (used in Tamr config template) to its value. If a variable name in this map(string) defines the same key as an input variable, the value specified in this map(string) takes precedence."
  default     = {}
}
