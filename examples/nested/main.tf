locals {
  az = "us-east-1e"
  tamr_vm_s3_actions = [
    "s3:PutObject",
    "s3:GetObject",
    "s3:DeleteObject",
    "s3:AbortMultipartUpload",
    "s3:ListBucket",
    "s3:ListObjects",
    "s3:CreateJob",
    "s3:HeadBucket"
  ]
}

# Set up VPC & subnet
resource "aws_vpc" "tamr_vm_vpc" {
  cidr_block = "1.2.3.0/24"
}

resource "aws_subnet" "tamr_vm_subnet" {
  vpc_id            = aws_vpc.tamr_vm_vpc.id
  cidr_block        = "1.2.3.0/24"
  availability_zone = local.az
}

# Set up HBase logs bucket
module "hbase-logs-bucket" {
  source             = "git::git@github.com:Datatamer/terraform-aws-s3.git?ref=0.1.0"
  bucket_name        = "test-hbase-logs-bucket"
  read_write_actions = local.tamr_vm_s3_actions
  read_write_paths   = [""] # r/w policy permitting specified rw actions on entire bucket
}

# Set up HBase root directory bucket
module "hbase-rootdir-bucket" {
  source             = "git::git@github.com:Datatamer/terraform-aws-s3.git?ref=0.1.0"
  bucket_name        = "test-hbase-root-directory-bucket"
  read_write_actions = local.tamr_vm_s3_actions
  read_write_paths   = [""] # r/w policy permitting default rw actions on entire bucket
}

# Set up Spark logs bucket
module "spark-logs-bucket" {
  source             = "git::git@github.com:Datatamer/terraform-aws-s3.git?ref=0.1.0"
  bucket_name        = "test-spark-logs-bucket"
  read_write_actions = local.tamr_vm_s3_actions
  read_write_paths   = [""] # r/w policy permitting specified rw actions on entire bucket
}

# Upload bootstrap scripts to S3
resource "aws_s3_bucket_object" "install_pip_bootstrap_script" {
  bucket                 = module.hbase-rootdir-bucket.bucket_name
  key                    = "bootstrap-script-tamr-vm/install-pip.sh"
  source                 = "./test-bootstrap-scripts/install-pip.sh"
  content_type           = "text/x-shellscript"
  server_side_encryption = "AES256"
}

resource "aws_s3_bucket_object" "check_pip_install_script" {
  bucket                 = module.hbase-rootdir-bucket.bucket_name
  key                    = "bootstrap-script-tamr-vm/check-install.sh"
  source                 = "./test-bootstrap-scripts/check-install.sh"
  content_type           = "text/x-shellscript"
  server_side_encryption = "AES256"
}

# Retrieve content of bootstrap script S3 objects
data "aws_s3_bucket_object" "bootstrap_script" {
  bucket = module.hbase-rootdir-bucket.bucket_name
  key    = aws_s3_bucket_object.install_pip_bootstrap_script.id
}

data "aws_s3_bucket_object" "bootstrap_script_2" {
  bucket = module.hbase-rootdir-bucket.bucket_name
  key    = aws_s3_bucket_object.check_pip_install_script.id
}

# Create new EC2 key pair
resource "tls_private_key" "tamr_ec2_private_key" {
  algorithm = "RSA"
}

module "tamr_ec2_key_pair" {
  source     = "terraform-aws-modules/key-pair/aws"
  key_name   = "tamr-ec2-test-key"
  public_key = tls_private_key.tamr_ec2_private_key.public_key_openssh
}

## Nested modules (minus the VM)

module "aws-iam-role" {
  source                    = "git::git@github.com:Datatamer/terraform-aws-tamr-vm.git//modules/aws-iam-role?ref=0.6.0"
  aws_role_name             = "nested-example-tamr-ec2-role"
  aws_instance_profile_name = "nested-example-tamr-ec2-instance-profile"
}

module "aws-iam-policies" {
  source                      = "git::git@github.com:Datatamer/terraform-aws-tamr-vm.git//modules/aws-iam-policies?ref=0.6.0"
  aws_role_name               = module.aws-iam-role.tamr_instance_role_name
  aws_emr_creator_policy_name = "NestedExampleEmrCreatorPolicy"
  s3_policy_arns = [
module.hbase-rootdir-bucket.rw_policy_arn,
module.hbase-logs-bucket.rw_policy_arn,
module.spark-logs-bucket.rw_policy_arn
]
}

module "aws-security-groups" {
  source                  = "git::git@github.com:Datatamer/terraform-aws-tamr-vm.git//modules/aws-security-groups?ref=0.6.0"
  sg_name                 = "nested-example-vm-sg"
  vpc_id                  = aws_vpc.tamr_vm_vpc.id
  ingress_cidr_blocks     = [aws_vpc.tamr_vm_vpc.cidr_block]
}
