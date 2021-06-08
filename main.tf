//working example for Tamr EMR account
module "aws-iam-role" {
  source                    = "./modules/aws-iam-role"
  aws_role_name             = var.aws_role_name
  aws_instance_profile_name = var.aws_instance_profile_name
}

module "aws-iam-policies" {
  source                      = "./modules/aws-iam-policies"
  aws_role_name               = module.aws-iam-role.tamr_instance_role_name
  aws_emr_creator_policy_name = var.aws_emr_creator_policy_name
  s3_policy_arns              = var.s3_policy_arns
}

module "aws-security-groups" {
  source                  = "./modules/aws-security-groups"
  sg_name                 = var.sg_name
  vpc_id                  = var.vpc_id
  ports                   = var.ports
  ingress_cidr_blocks     = var.ingress_cidr_blocks
  ingress_security_groups = var.ingress_security_groups
  egress_cidr_blocks      = var.egress_cidr_blocks
  egress_security_groups  = var.egress_security_groups
  additional_tags         = var.security_group_tags
}

module "tamr_instance" {
  source     = "./modules/aws-ec2-instance"
  depends_on = [module.aws-iam-policies]

  ami                      = var.ami
  availability_zone        = var.availability_zone
  instance_type            = var.instance_type
  iam_instance_profile     = module.aws-iam-role.tamr_instance_profile_id
  key_name                 = var.key_name
  security_group_ids       = module.aws-security-groups.security_group_ids
  subnet_id                = var.subnet_id
  volume_type              = var.volume_type
  volume_size              = var.volume_size
  enable_volume_encryption = var.enable_volume_encryption
  bootstrap_scripts        = var.bootstrap_scripts
  additional_tags          = var.tamr_instance_tags
}
