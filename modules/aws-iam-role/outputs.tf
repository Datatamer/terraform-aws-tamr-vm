output "tamr_emr_iam_role_arn" {
  value = aws_iam_role.tamr_user_iam_role.arn
  description = "ARN of the IAM role created"
}
