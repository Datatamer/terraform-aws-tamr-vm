output "emr_creator_policy_arn" {
  value       = aws_iam_policy.emr_creator_minimal_policy.arn
  description = "ARN of the EMR creator IAM policy created."
}

output "s3_policy_arns" {
  value       = var.s3_policy_arns
  description = "List of ARNs of S3 policies attached to Tamr user IAM role"
}
