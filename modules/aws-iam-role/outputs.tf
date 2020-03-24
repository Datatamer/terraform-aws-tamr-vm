output "tamr_instance_profile_id" {
  value = aws_iam_role.tamr_user_instance_profile.id
  description = "ID of the IAM instance profile created"
}
