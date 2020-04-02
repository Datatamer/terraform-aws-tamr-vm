output "tamr_security_group_id" {
  value = module.aws_security_group.tamr-vm-sg.id
  description = "ID of the security group created"
}
