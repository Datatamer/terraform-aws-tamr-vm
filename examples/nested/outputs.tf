output "vpc_id" {
  value = aws_vpc.tamr_vm_vpc.id
}

output "subnet_id" {
  value = aws_subnet.tamr_vm_subnet.id
}

output "aws-iam-policies" {
  value = module.aws-iam-policies
}

output "aws-iam-role" {
  value = module.aws-iam-role
}

output "aws-security-groups" {
  value = module.aws-security-groups
}
