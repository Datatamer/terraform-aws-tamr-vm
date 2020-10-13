output "ec2_instance_id" {
  value       = aws_instance.tamr-instance.id
  description = "The ID of the instance created"
}

output "tamr_instance_ip" {
  value       = aws_instance.tamr-instance.private_ip
  description = "The private IP address of the EC2 instance created"
}
