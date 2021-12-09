locals {
  az = "us-east-2a"
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

# Get current Region
data "aws_region" "current" {}

# Get CloudWatchAgentServerPolicy
data "aws_iam_policy" "cw-agent-server-policy" {
  arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# Attach CloudWatchAgentServerPolicy to tamr-vm
resource "aws_iam_role_policy_attachment" "cw-agent-server-policy" {
  role       = module.tamr-vm.tamr_iam_role.tamr_instance_role_name
  policy_arn = data.aws_iam_policy.cw-agent-server-policy.arn
}

# Set up VPC & subnet
resource "aws_vpc" "tamr_vm_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = var.tags
}

resource "aws_subnet" "tamr_vm_subnet" {
  vpc_id            = aws_vpc.tamr_vm_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = local.az
  tags              = var.tags
}

# Set up HBase logs bucket
module "s3-bucket" {
  source             = "git::git@github.com:Datatamer/terraform-aws-s3.git?ref=1.1.0"
  bucket_name        = format("%s-tamr-module-test-bucket", var.name-prefix)
  read_write_actions = local.tamr_vm_s3_actions
  read_write_paths   = [""] # r/w policy permitting specified rw actions on entire bucket
  additional_tags    = var.tags
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

module "aws-vm-sg-ports" {
  #source = "git::https://github.com/Datatamer/terraform-aws-tamr-vm.git//modules/aws-security-groups?ref=2.0.0"
  source = "../../modules/aws-security-groups"
}

module "aws-sg" {
  source = "git::git@github.com:Datatamer/terraform-aws-security-groups.git?ref=1.0.0"
  vpc_id = aws_vpc.tamr_vm_vpc.id
  ingress_cidr_blocks = [
    "10.0.0.0/24"
  ]
  egress_cidr_blocks = [
    "0.0.0.0/0"
  ]
  ingress_ports    = module.aws-vm-sg-ports.ingress_ports
  sg_name_prefix   = var.name-prefix
  ingress_protocol = var.ingress_protocol
  egress_protocol  = "all"
  tags             = var.tags
}

module "tamr-vm" {

  source                      = "../.."
  aws_role_name               = format("%s-tamr-ec2-role", var.name-prefix)
  aws_instance_profile_name   = format("%s-tamr-ec2-instance-profile", var.name-prefix)
  aws_emr_creator_policy_name = format("%sEmrCreatorPolicy", var.name-prefix)
  s3_policy_arns = [
    module.s3-bucket.rw_policy_arn,
  ]
  ami               = var.ami_id
  instance_type     = "r5.2xlarge"
  key_name          = module.tamr_ec2_key_pair.key_pair_key_name
  availability_zone = local.az
  ingress_protocol  = var.ingress_protocol
  egress_protocol   = var.egress_protocol
  vpc_id            = aws_vpc.tamr_vm_vpc.id
  subnet_id         = aws_subnet.tamr_vm_subnet.id
  bootstrap_scripts = [

    # NOTE: If you would like to use local scripts, you can use terraform's file() function
    templatefile("./test-bootstrap-scripts/cloudwatch-install.sh", { region = data.aws_region.current.name, endpoint = module.endpoints.endpoints["logs"].dns_entry[0]["dns_name"] }),
  ]

  security_group_ids = module.aws-sg.security_group_ids
  tags               = var.tags
}

resource "aws_route_table" "example" {
  vpc_id = aws_vpc.tamr_vm_vpc.id
  tags   = var.tags
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.tamr_vm_subnet.id
  route_table_id = aws_route_table.example.id
}

module "endpoints" {

  source = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"

  vpc_id = aws_vpc.tamr_vm_vpc.id

  endpoints = {
    s3 = {
      service_type    = "Gateway"
      service         = "s3"
      tags            = { Name = format("%s-%s", var.name-prefix, "s3-vpc-endpoint") }
      route_table_ids = flatten([aws_route_table.example.id])
    },
    logs = {
      service_type        = "Interface"
      service             = "logs"
      tags                = { Name = "cloudwatch-vpc-endpoint" }
      private_dns_enabled = true
      security_group_ids  = [aws_security_group.interface_endpoint.id]
      subnet_ids          = [aws_subnet.tamr_vm_subnet.id]
    },
  }
  tags = var.tags
}

resource "aws_security_group" "interface_endpoint" {
  name        = format("%s-%s", var.name-prefix, "interface-endpoint-sg")
  description = "Security Group to be attached to the Cloudwatch Endpoint interface, which allows TCP traffic to the EMR service."
  vpc_id      = aws_vpc.tamr_vm_vpc.id

  ingress {
    description     = "Cloudwatch API"
    from_port       = 443
    to_port         = 443
    protocol        = "TCP"
    security_groups = [module.aws-sg.security_group_ids[1]]
  }
  tags = var.tags
}
