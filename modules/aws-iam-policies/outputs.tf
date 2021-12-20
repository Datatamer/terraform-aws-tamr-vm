output "emr_creator_policy_arn" {
  value       = aws_iam_policy.emr_creator_minimal_policy.arn
  description = "ARN of the EMR creator IAM policy created."
}

output "additional_policy_arns" {
  value       = var.additional_policy_arns
  description = "List of policy ARNs to be attached to Tamr VM IAM role."
}
