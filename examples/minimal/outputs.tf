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

output "tamr_private_key" {
  value = tls_private_key.tamr_ec2_private_key.private_key_pem
}

output "tamr_vm" {
  value = module.tamr-vm
}
