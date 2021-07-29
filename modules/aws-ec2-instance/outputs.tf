output "ec2_instance_id" {
  value       = aws_instance.tamr-instance.id
  description = "The ID of the instance created"
}

output "tamr_instance_ip" {
  value       = aws_instance.tamr-instance.private_ip
  description = "The private IP address of the EC2 instance created"
}

output "bootstrap_scripts" {
  value       = length(var.bootstrap_scripts) == 0 ? "" : data.template_cloudinit_config.bootstrap-scripts[0].rendered
  description = "The final rendered multi-part cloud-init config."
}

output "tamr_instance_eni" {
  value       = aws_network_interface.tamr-instance-network.id
  description = "The eni ID of the EC2 instance created"
}