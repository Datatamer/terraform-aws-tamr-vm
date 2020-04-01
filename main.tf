//working example for Tamr EMR account
module "aws-iam-role" {
  source = "./modules/aws-iam-role"
  aws_role_name = "example-tamr-role"
}

module "aws-iam-policies" {
  source = "./modules/aws-iam-policies"
  aws_role_name = module.aws-iam-role.tamr_instance_role_name
  aws_account_id = "${var.aws_account_id}"
  aws_emrfs_hbase_bucket_name = "${var.aws_emrfs_hbase_bucket_name}"
  aws_emrfs_hbase_logs_bucket_name = "${var.aws_emrfs_hbase_logs_bucket_name}"
  aws_emrfs_spark_logs_bucket_name = "${var.aws_emrfs_spark_logs_bucket_name}"
}

module "aws-security-groups" {
  source = "./modules/aws-security-groups"
  vpc_id = "${var.vpc_id}"
  ingress_cidr_blocks = var.ingress_cidr_blocks
}

module "tamr_instance" {
  source = "./modules/aws-ec2-instance"
  ami = var.ami
  instance_type = "${var.instance_type}"
  iam_instance_profile = module.aws-iam-role.tamr_instance_profile_id
  key_name = "${var.key_name}"
  security_group_ids = ["${module.aws-security-groups.tamr_security_group_id}"]
  subnet_id = "${var.subnet_id}"
}
