output "ec2_instance_id" {
  value       = "${aws_instance.tamr-instance.id}"
  description = "The ID of the instance created"
}
