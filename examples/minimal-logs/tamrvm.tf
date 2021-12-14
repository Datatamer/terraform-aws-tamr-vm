locals {
  az = data.aws_availability_zones.available.names
}

# Get available AZs
data "aws_availability_zones" "available" {
  state = "available"
}

# Get current Region
data "aws_region" "current" {}

# Create new EC2 key pair
resource "tls_private_key" "tamr_ec2_private_key" {
  algorithm = "RSA"
}

module "tamr-vm" {
  source                      = "../../"
  aws_role_name               = format("%s-tamr-ec2-role", var.name-prefix)
  aws_instance_profile_name   = format("%s-tamr-ec2-instance-profile", var.name-prefix)
  aws_emr_creator_policy_name = format("%sEmrCreatorPolicy", var.name-prefix)
  s3_policy_arns = [
    module.s3-bucket.rw_policy_arn,
  ]
  ami               = var.ami_id
  instance_type     = "r5.2xlarge"
  key_name          = var.key_name
  availability_zone = local.az[0]
  vpc_id            = module.vpc.vpc_id
  ingress_protocol  = var.ingress_protocol
  egress_protocol   = "all"
  subnet_id         = module.vpc.application_subnet_id
  bootstrap_scripts = [

    # NOTE: If you would like to use local scripts, you can use terraform's file() function
    templatefile("./test-bootstrap-scripts/cloudwatch-install.sh", { region = data.aws_region.current.name, endpoint = module.endpoints.endpoints["logs"].dns_entry[0]["dns_name"], log_group = var.log_group, log_stream = var.log_stream }),
  ]

  security_group_ids = module.aws-sg.security_group_ids
  tags               = var.tags
}

