output "vpc_id" {
  value = module.vpc.vpc_id
}

output "tamr_private_key" {
  value     = tls_private_key.tamr_ec2_private_key.private_key_pem
  sensitive = true
}

output "tamr_vm" {
  value = module.tamr-vm
}

output "application_subnet_id" {
  value = module.vpc.application_subnet_id
}
