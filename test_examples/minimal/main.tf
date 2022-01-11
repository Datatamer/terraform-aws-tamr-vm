locals {
  all_tags = merge(
    var.tags,
    { "Terraform" : "True",
      "Terratest" : "True",
    "Name" : var.name_tag }

  )
}

module "examples_minimal" {
  source = "../../examples/minimal"

  name-prefix          = var.name-prefix
  vpc_cidr_block       = var.vpc_cidr_block
  vm_subnet_cidr_block = var.vm_subnet_cidr_block

  tamr_instance_tags   = local.all_tags

  ami_id = data.aws_ami.ubuntu.id
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "image-type"
    values = ["machine"]
  }

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }
}
