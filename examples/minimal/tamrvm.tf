locals {
  az = data.aws_availability_zones.available.names[0]
}

# Get available AZs
data "aws_availability_zones" "available" {
  state = "available"
}

# Create new EC2 key pair
resource "tls_private_key" "tamr_ec2_private_key" {
  algorithm = "RSA"
}

module "tamr_ec2_key_pair" {
  source     = "terraform-aws-modules/key-pair/aws"
  version    = "1.0.0"
  key_name   = format("%s-tamr-ec2-test-key", var.name-prefix)
  public_key = tls_private_key.tamr_ec2_private_key.public_key_openssh
  tags       = var.tags
}

module "tamr-vm" {
  source = "../../"
  aws_role_name               = format("%s-tamr-ec2-role", var.name-prefix)
  aws_instance_profile_name   = format("%s-tamr-ec2-instance-profile", var.name-prefix)
  aws_emr_creator_policy_name = format("%sEmrCreatorPolicy", var.name-prefix)
  s3_policy_arns = [
    module.s3-bucket.rw_policy_arn,
  ]
  ami               = var.ami_id
  instance_type     = "m4.2xlarge"
  key_name          = module.tamr_ec2_key_pair.key_pair_key_name
  availability_zone = local.az
  vpc_id            = aws_vpc.tamr_vm_vpc.id
  ingress_protocol = "tcp"
  egress_protocol  = "all"
  subnet_id         = aws_subnet.tamr_vm_subnet.id
  bootstrap_scripts = [
    # NOTE: If you would like to use local scripts, you can use terraform's file() function
    # file("./test-bootstrap-scripts/install-pip.sh"),
    # file("./test-bootstrap-scripts/check-install.sh"),
    data.aws_s3_bucket_object.bootstrap_script.body,
    data.aws_s3_bucket_object.bootstrap_script_2.body
  ]

  security_group_ids = module.aws-sg.security_group_ids
  tags               = var.tags
}
