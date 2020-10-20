# Tamr Config Module
This module renders a Tamr config given output values from other AWS scale-out modules.

# Examples
## Basic
Inline example implementation of the module. This is the most basic example of what it would look like to use this module.
```
module "tamr-config" {
  source                          = "git::https://github.com/Datatamer/terraform-aws-tamr-vm.git//modules/aws-tamr-config?ref=0.4.1"
  config_template_path            = "./tamr-config.yml"
  rds_pg_hostname                 = module.rds-postgres.rds_hostname
  rds_pg_dbname                   = module.rds-postgres.rds_dbname
  rds_pg_username                 = module.rds-postgres.rds_username
  rds_pg_password                 = random_password.rds-password.result
  root_directory_bucket_name      = module.s3-data.bucket_name
  logs_bucket_name                = module.s3-logs.bucket_name
  emr_cluster_name                = module.emr.tamr_emr_cluster_name
  emr_cluster_id                  = module.emr.tamr_emr_cluster_id
  es_domain_endpoint              = module.tamr-es-cluster.tamr_es_domain_endpoint
  tamr_hbase_namespace            = "example-ns0"
  tamr_spark_driver_memory        = "5G"
  tamr_spark_executor_instances   = 2
  tamr_spark_executor_memory      = "8G"
  tamr_spark_executor_cores       = 2
  tamr_spark_properties_override  = ""
  tamr_external_storage_providers = ""
  additional_templated_variables = {
    "tamr_license_key" : "example-license-key"  # tamr-config.yml (or whatever config template you provided the path to) should have TAMR_LICENSE_KEY = ${tamr_license_key}
  }
}

output "tamr-config" {
  value = module.tamr-config.rendered
}
```

# Resources Created
This module creates:
* a template_file data source which renders the contents of a populated Tamr config.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| aws | >= 2.45.0 |

## Providers

| Name | Version |
|------|---------|
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| emr\_cluster\_id | EMR cluster ID | `string` | n/a | yes |
| emr\_cluster\_name | Name of EMR cluster | `string` | n/a | yes |
| logs\_bucket\_name | Name of Tamr logs bucket. | `string` | n/a | yes |
| rds\_pg\_dbname | RDS postgres database name | `string` | n/a | yes |
| rds\_pg\_hostname | Host name for the RDS postgres instance | `string` | n/a | yes |
| rds\_pg\_password | Password for the RDS postgres database instance | `string` | n/a | yes |
| rds\_pg\_username | Username for the RDS postgres database instance | `string` | n/a | yes |
| root\_directory\_bucket\_name | Name of Tamr root directory bucket. | `string` | n/a | yes |
| tamr\_hbase\_namespace | Other inputs | `string` | n/a | yes |
| additional\_templated\_variables | Map of variable name (used in Tamr config template) to its value. If a variable name in this map(string) defines the same key as an input variable, the value specified in this map(string) takes precedence. | `map(string)` | `{}` | no |
| config\_template\_path | Path to Tamr config template. | `string` | `"./tamr-config.yml"` | no |
| es\_domain\_endpoint | Endpoint of Elasticsearch domain | `string` | `""` | no |
| tamr\_external\_storage\_providers | Filesystem connection information for external storage providers. | `string` | `""` | no |
| tamr\_spark\_driver\_memory | n/a | `string` | `"5G"` | no |
| tamr\_spark\_executor\_cores | n/a | `number` | `2` | no |
| tamr\_spark\_executor\_instances | n/a | `number` | `2` | no |
| tamr\_spark\_executor\_memory | n/a | `string` | `"8G"` | no |
| tamr\_spark\_properties\_override | JSON blob of spark properties to override. If not set, will use a default set of properties that should work for most use cases | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| rendered | Rendered yaml Tamr config |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# References
This repo is based on:
* [terraform standard module structure](https://www.terraform.io/docs/modules/index.html#standard-module-structure)
* [templated terraform module](https://github.com/tmknom/template-terraform-module)

# License
Apache 2 Licensed. See LICENSE for full details.
