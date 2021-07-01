/*
reduced permissions role for EMR. Some permissions can be limited to clusters,
while others must have access to all EMR in order to operate correctly.
*/
resource "aws_iam_policy" "emr_creator_minimal_policy" {
  name   = var.aws_emr_creator_policy_name
  policy = data.aws_iam_policy_document.emr_creator_policy.json
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

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
    resources = flatten([
      length(var.tamr_emr_role_arns) == 0 ?
      ["arn:${var.arn_partition}:iam::${data.aws_caller_identity.current.account_id}:role/*"] :
      [for emr_role_arn in var.tamr_emr_role_arns :
        emr_role_arn
      ],
      length(var.tamr_emr_cluster_ids) == 0 ?
      ["arn:${var.arn_partition}:elasticmapreduce:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:cluster/*"] :
      [for emr_id in var.tamr_emr_cluster_ids :
        "arn:${var.arn_partition}:elasticmapreduce:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:cluster/${emr_id}"
      ]
      ]
    )
  }
  statement {
    effect = "Allow"
    actions = [
      "elasticmapreduce:RunJobFlow",
      "elasticmapreduce:DescribeRepository",
      "elasticmapreduce:DescribeSecurityConfiguration",
    ]
    resources = [
      "arn:${var.arn_partition}:elasticmapreduce:*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "elasticmapreduce:ListClusters"
    ]
    resources = ["*"]
  }


  statement {
    effect = "Allow"
    actions = [
      "elasticmapreduce:DescribeCluster",
      "elasticmapreduce:DescribeJobFlows",
      "elasticmapreduce:DescribeStep"
    ]
    resources = flatten([length(var.tamr_emr_cluster_ids) == 0 ?
      ["arn:${var.arn_partition}:elasticmapreduce:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:cluster/*"] :
      [for emr_id in var.tamr_emr_cluster_ids :
        "arn:${var.arn_partition}:elasticmapreduce:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:cluster/${emr_id}"
      ]
    ])
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
