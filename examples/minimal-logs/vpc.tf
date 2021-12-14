# Set up VPC & subnet
module "vpc" {
  source = "git::https://github.com/Datatamer/terraform-aws-networking.git?ref=0.1.0"
  #ingress_cidr_blocks           = ["172.16.0.0/16"]
  vpc_cidr_block                = "10.0.0.0/16"
  data_subnet_cidr_blocks       = ["10.0.2.0/24", "10.0.3.0/24"]
  application_subnet_cidr_block = "10.0.0.0/24"
  compute_subnet_cidr_block     = "10.0.1.0/24"
  availability_zones            = [local.az[0], local.az[1]]
  create_public_subnets         = false
  create_load_balancing_subnets = false
  enable_nat_gateway            = false
  tags                          = var.tags
}

module "aws-vm-sg-ports" {
  #source = "git::https://github.com/Datatamer/terraform-aws-tamr-vm.git//modules/aws-security-groups?ref=2.0.0"
  source = "../../modules/aws-security-groups"
}

#Creates a security group for the Tamr VM
module "aws-sg" {
  source = "git::git@github.com:Datatamer/terraform-aws-security-groups.git?ref=1.0.0"
  vpc_id = module.vpc.vpc_id
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

#Creates a security group for the VPC Interface Endpoint
module "aws-endpoint-sg" {
  source                  = "git::git@github.com:Datatamer/terraform-aws-security-groups.git?ref=1.0.0"
  vpc_id                  = module.vpc.vpc_id
  ingress_ports           = [443]
  ingress_security_groups = [module.aws-sg.security_group_ids[1]]
  sg_name_prefix          = format("%s-%s", var.name-prefix, "interface-endpoint-sg")
  ingress_protocol        = "tcp"
  egress_protocol         = "all"
  tags                    = var.tags
}

#Create VPC Interface Endpoint for Cloudwatch
module "endpoints" {
  source = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  vpc_id = module.vpc.vpc_id

  endpoints = {
    logs = {
      service_type        = "Interface"
      service             = "logs"
      tags                = { Name = "cloudwatch-vpc-endpoint" }
      private_dns_enabled = true
      security_group_ids  = module.aws-endpoint-sg.security_group_ids
      subnet_ids          = [module.vpc.application_subnet_id]
    },
  }
  tags = var.tags
}
