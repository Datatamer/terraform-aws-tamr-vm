output "vpc_id" {
  value = aws_vpc.tamr_vm_vpc.id
}

output "subnet_id" {
  value = aws_subnet.tamr_vm_subnet.id
}

output "tamr_key_pair_name" {
  value       = module.tamr_ec2_key_pair.this_key_pair_key_name
  description = "Name of EC2 key pair created for Tamr instance"
}

output "tamr_security_group_id" {
  value       = module.tamr-vm.tamr_security_group_id
  description = "ID of the security group created"
}

output "tamr_instance_ip" {
  value       = module.tamr-vm.tamr_instance_ip
  description = "Private IP address of the Tamr instance"
}

output "tamr_instance_id" {
  value       = module.tamr-vm.tamr_instance_id
  description = "The ID of the Tamr instance created"
}

output "tamr_instance_profile_id" {
  value       = module.tamr-vm.tamr_instance_profile_id
  description = "ID of the IAM instance profile created"
}

output "tamr_instance_role_name" {
  value       = module.tamr-vm.tamr_instance_role_name
  description = "ID of the Tamr user IAM role created"
}

output "emr_creator_policy_arn" {
  value       = module.tamr-vm.emr_creator_policy_arn
  description = "ARN of the EMR creator IAM policy created."
}

output "s3_policy_arns" {
  value       = module.tamr-vm.s3_policy_arns
  description = "List of ARNs of S3 policies attached to Tamr user IAM role"
}
