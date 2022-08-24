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
