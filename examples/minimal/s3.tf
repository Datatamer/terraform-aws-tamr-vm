locals {
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

# Set up HBase logs bucket
module "s3-bucket" {
  source             = "git::git@github.com:Datatamer/terraform-aws-s3.git?ref=1.3.2"
  bucket_name        = format("%s-tamr-module-test-bucket", var.name-prefix)
  read_write_actions = local.tamr_vm_s3_actions
  read_write_paths   = [""] # r/w policy permitting specified rw actions on entire bucket
  additional_tags    = var.tags
}

# Upload bootstrap scripts to S3
resource "aws_s3_bucket_object" "install_pip_bootstrap_script" {
  bucket                 = module.s3-bucket.bucket_name
  key                    = "bootstrap-script-tamr-vm/install-pip.sh"
  source                 = var.install_script_path
  content_type           = "text/x-shellscript"
  server_side_encryption = "AES256"
  tags                   = var.tags
}

resource "aws_s3_bucket_object" "check_pip_install_script" {
  bucket                 = module.s3-bucket.bucket_name
  key                    = "bootstrap-script-tamr-vm/check-install.sh"
  source                 = var.check_install_script_path
  content_type           = "text/x-shellscript"
  server_side_encryption = "AES256"
  tags                   = var.tags
}

# Retrieve content of bootstrap script S3 objects
data "aws_s3_bucket_object" "bootstrap_script" {
  bucket = module.s3-bucket.bucket_name
  key    = aws_s3_bucket_object.install_pip_bootstrap_script.id
}

data "aws_s3_bucket_object" "bootstrap_script_2" {
  bucket = module.s3-bucket.bucket_name
  key    = aws_s3_bucket_object.check_pip_install_script.id
}
