locals {
  effective_policy_arns = length(var.additional_policy_arns) > 0 ? var.additional_policy_arns : var.s3_policy_arns
}

module "aws-iam-role" {
  source                    = "./modules/aws-iam-role"
  aws_role_name             = var.aws_role_name
  aws_instance_profile_name = var.aws_instance_profile_name
  permissions_boundary      = var.permissions_boundary
  tags                      = var.tags
}

module "aws-iam-policies" {
  source                      = "./modules/aws-iam-policies"
  aws_role_name               = module.aws-iam-role.tamr_instance_role_name
  aws_emr_creator_policy_name = var.aws_emr_creator_policy_name
  additional_policy_arns      = local.effective_policy_arns
  tamr_emr_cluster_ids        = var.tamr_emr_cluster_ids
  tamr_emr_role_arns          = var.tamr_emr_role_arns
  tags                        = var.tags
  emr_abac_valid_tags         = var.emr_abac_valid_tags
}


module "tamr_instance" {
  source     = "./modules/aws-ec2-instance"
  depends_on = [module.aws-iam-policies]

  ami                                  = var.ami
  availability_zone                    = var.availability_zone
  instance_type                        = var.instance_type
  iam_instance_profile                 = module.aws-iam-role.tamr_instance_profile_id
  key_name                             = var.key_name
  security_group_ids                   = var.security_group_ids
  subnet_id                            = var.subnet_id
  private_ips                          = var.private_ips
  volume_type                          = var.volume_type
  volume_size                          = var.volume_size
  enable_volume_encryption             = var.enable_volume_encryption
  bootstrap_scripts                    = var.bootstrap_scripts
  tags                                 = merge(var.tags, var.tamr_instance_tags)
  require_http_tokens                  = var.require_http_tokens
  pre_install_bash                     = var.pre_install_bash
  tamr_zip_uri                         = var.tamr_zip_uri
  tamr_config_file                     = var.tamr_config_file
  tamr_instance_install_directory      = var.tamr_instance_install_directory
  tamr_filesystem_bucket               = var.tamr_filesystem_bucket
}
