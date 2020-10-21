output "tamr_security_groups" {
  value = module.aws-security-groups
}

output "tamr_instance" {
  value = module.tamr_instance
}

output "tamr_iam_role" {
  value = module.aws-iam-role
}

output "tamr_iam_policies" {
  value = module.aws-iam-policies
}
