# Set up VPC & subnet
module "vpc" {
  source             = "git::https://github.com/Datatamer/terraform-aws-networking.git?ref=1.1.1"
  availability_zones = [local.az[0], local.az[1]]
  name_prefix        = var.name-prefix
  tags               = var.tags
  # Cidr Blocks
  vpc_cidr_block                = "10.0.0.0/16"
  application_subnet_cidr_block = "10.0.0.0/24"
  data_subnet_cidr_blocks       = ["10.0.2.0/24", "10.0.3.0/24"]
  compute_subnet_cidr_block     = "10.0.1.0/24"
  # Create subnets flag
  create_public_subnets         = false
  create_load_balancing_subnets = false
  enable_nat_gateway            = false
  # Allowed security group for accepting ingress traffic to the EMR Interface Endpoint
  interface_endpoint_ingress_sg = module.aws-sg.security_group_ids[0]
}

module "aws-vm-sg-ports" {
  #source = "git::https://github.com/Datatamer/terraform-aws-tamr-vm.git//modules/aws-security-groups?ref=2.0.0"
  source = "../../modules/aws-security-groups"
}

#Creates a security group for the Tamr VM
module "aws-sg" {
  source = "git::git@github.com:Datatamer/terraform-aws-security-groups.git?ref=1.0.1"
  vpc_id = module.vpc.vpc_id
  ingress_cidr_blocks = [
    "10.0.0.0/24"
  ]
  egress_cidr_blocks = [
    "0.0.0.0/0"
  ]
  ingress_ports    = module.aws-vm-sg-ports.ingress_ports
  sg_name_prefix   = var.name-prefix
  ingress_protocol = "tcp"
  egress_protocol  = "all"
  tags             = var.tags
}
