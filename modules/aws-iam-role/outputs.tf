output "tamr_instance_profile_id" {
  value       = aws_iam_instance_profile.tamr_user_instance_profile.id
  description = "ID of the IAM instance profile created"
}

output "tamr_instance_role_name" {
  value       = aws_iam_role.tamr_user_iam_role.id
  description = "ID of the role created"
}
