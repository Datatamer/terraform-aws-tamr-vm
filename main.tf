//working example for Tamr EMR account

provider "aws" {
  version             = "2.45.0"
  region              = "us-east-1"
  allowed_account_ids = ["825693534638"]
}

module "aws-iam-role" {
  source = "./modules/aws-iam-role"
  aws_role_name = "example-tamr-role"
}

module "aws-iam-policies" {
  source = "./modules/aws-iam-policies"
  aws_role_name = module.aws-iam-role.tamr_instance_role_name
  aws_account_id = "825693534638"
  aws_emrfs_hbase_bucket_name = "emr-alpha-hbase-rootdir"
  aws_emrfs_hbase_logs_bucket_name = "emrfs-minimal-permissions-test"
  aws_emrfs_spark_logs_bucket_name = "tamr-s3-testing"
}

module "aws-security-groups" {
  source = "./modules/aws-security-groups"
  vpc_id = "vpc-09186b4fd7031cf87"
  ingress_cidr_blocks = [
    "10.30.0.12/32",
    "0.0.0.0/0",
  ]
}

module "tamr_instance" {
  source = "./modules/aws-ec2-instance"
  ami = "ami-0a4f4704a9146742a"
  iam_instance_profile = module.aws-iam-role.tamr_instance_profile_id
  key_name = "tamr-emr-dev"
  security_group_ids = ["${module.aws-security-groups.tamr_security_group_id}"]
  subnet_id = "subnet-0a6dce24beba1d027"
}
