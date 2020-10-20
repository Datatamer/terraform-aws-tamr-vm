data "template_file" "tamr_config" {
  template = file(var.config_template_path)
  vars = merge({
    tamr_pg_db_hostname             = var.rds_pg_hostname,
    tamr_pg_db_name                 = var.rds_pg_dbname,
    tamr_pg_user                    = var.rds_pg_username,
    tamr_pg_password                = var.rds_pg_password,
    tamr_data_bucket                = var.root_directory_bucket_name,
    tamr_logs_bucket                = var.logs_bucket_name,
    tamr_cluster_name               = var.emr_cluster_name,
    tamr_emr_cluster_id             = var.emr_cluster_id,
    tamr_es_domain_endpoint         = var.es_domain_endpoint,
    tamr_hbase_namespace            = var.tamr_hbase_namespace,
    tamr_spark_driver_memory        = var.tamr_spark_driver_memory,
    tamr_spark_executor_instances   = var.tamr_spark_executor_instances,
    tamr_spark_executor_memory      = var.tamr_spark_executor_memory,
    tamr_spark_executor_cores       = var.tamr_spark_executor_cores,
    tamr_spark_properties_override  = var.tamr_spark_properties_override,
    tamr_external_storage_providers = var.tamr_external_storage_providers
  }, var.additional_templated_variables)
}
