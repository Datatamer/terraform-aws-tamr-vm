# Set up VPC & subnet
#tfsec:ignore:aws-ec2-require-vpc-flow-logs-for-all-vpcs
resource "aws_vpc" "tamr_vm_vpc" {
  cidr_block = var.vpc_cidr_block
  tags       = var.tags
}

resource "aws_subnet" "tamr_vm_subnet" {
  vpc_id            = aws_vpc.tamr_vm_vpc.id
  cidr_block        = var.vm_subnet_cidr_block
  availability_zone = local.az[0]
  tags              = var.tags
}

module "aws-vm-sg-ports" {
  #source = "git::https://github.com/Datatamer/terraform-aws-tamr-vm.git//modules/aws-security-groups?ref=2.0.0"
  source = "../../modules/aws-security-groups"
}

module "aws-sg" {
  source = "git::git@github.com:Datatamer/terraform-aws-security-groups.git?ref=1.0.1"
  vpc_id = aws_vpc.tamr_vm_vpc.id
  ingress_cidr_blocks = [
    "1.2.3.0/24"
  ]
  egress_cidr_blocks = [
    "0.0.0.0/0"
  ]
  ingress_ports    = module.aws-vm-sg-ports.ingress_ports
  ingress_protocol = "tcp"
  egress_protocol  = "all"
  sg_name_prefix   = var.name-prefix
  tags             = var.tags
}
