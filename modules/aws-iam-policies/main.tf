/*
reduced permissions role for EMR. Some permissions can be limited to clusters,
while others must have access to all EMR in order to operate correctly.
*/
resource "aws_iam_policy" "emr_creator_minimal_policy" {
  name   = var.aws_emr_creator_policy_name
  policy = data.aws_iam_policy_document.emr_creator_policy.json
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "emr_creator_policy" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    actions = [
      "elasticmapreduce:AddInstanceGroups",
      "elasticmapreduce:AddJobFlowSteps",
      "elasticmapreduce:ListBootstrapActions",
      "elasticmapreduce:ListInstances",
      "elasticmapreduce:ListInstanceGroups",
      "elasticmapreduce:ListSteps",
      "elasticmapreduce:TerminateJobFlows",
      "iam:PassRole"
    ]
    resources = [
      "arn:${var.arn_partition}:iam::${data.aws_caller_identity.current.account_id}:role/*",
      "arn:${var.arn_partition}:elasticmapreduce:*:${data.aws_caller_identity.current.account_id}:cluster/*"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "elasticmapreduce:RunJobFlow"
    ]
    resources = [
      "arn:${var.arn_partition}:elasticmapreduce:*"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "elasticmapreduce:Describe*",
      "elasticmapreduce:ListClusters"
    ]
    resources = ["*"]
  }
}

//Attach the above policy to an existing user
resource "aws_iam_role_policy_attachment" "emr_creator_policy_attachment" {
  role       = var.aws_role_name
  policy_arn = aws_iam_policy.emr_creator_minimal_policy.arn
}

// IAM role policy attachment(s) that attach s3 policy ARNs to Tamr user IAM role
resource "aws_iam_role_policy_attachment" "emrfs_user_s3_policy" {
  count      = length(var.s3_policy_arns)
  role       = var.aws_role_name
  policy_arn = element(var.s3_policy_arns, count.index)
}
