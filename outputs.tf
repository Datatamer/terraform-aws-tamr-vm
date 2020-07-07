output "tamr_security_group_id" {
  value       = module.aws-security-groups.tamr_security_group_id
  description = "ID of the security group created"
}

output "tamr_instance_ip" {
  value       = module.tamr_instance.tamr_instance_ip
  description = "Private IP address of the Tamr instance"
}
