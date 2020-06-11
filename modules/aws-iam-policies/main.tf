/*
reduced permissions role for EMR. Some permissions can be limited to clusters,
while others must have access to all EMR in order to operate correctly.
*/
resource "aws_iam_policy" "emr_creator_minimal_policy" {
  name   = var.aws_emr_creator_policy_name
  policy = data.aws_iam_policy_document.emr_creator_policy.json
}

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
      "arn:aws:iam::${var.aws_account_id}:role/*",
      "arn:aws:elasticmapreduce:*:${var.aws_account_id}:cluster/*"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "elasticmapreduce:RunJobFlow"
    ]
    resources = [
        "arn:aws:elasticmapreduce:*"
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
  role       = "${var.aws_role_name}"
  policy_arn = "${aws_iam_policy.emr_creator_minimal_policy.arn}"
}

// reduced permissions policy for Tamr user to be able to access EMRFS
resource "aws_iam_policy" "emrfs_user_minimal_policy" {
  name   = var.aws_emrfs_user_policy_name
  policy = data.aws_iam_policy_document.emrfs_user_policy.json
}

data "aws_iam_policy_document" "emrfs_user_policy" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:AbortMultipartUpload",
      "s3:ListBucket"
    ]
    resources = [
      "arn:aws:s3:::${var.aws_emrfs_hbase_bucket_name}/*",
      "arn:aws:s3:::${var.aws_emrfs_hbase_bucket_name}",
      "arn:aws:s3:::${var.aws_emrfs_hbase_logs_bucket_name}",
      "arn:aws:s3:::${var.aws_emrfs_hbase_logs_bucket_name}/*",
      "arn:aws:s3:::${var.aws_emrfs_spark_logs_bucket_name}",
      "arn:aws:s3:::${var.aws_emrfs_spark_logs_bucket_name}/*"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:CreateJob",
      "s3:HeadBucket"
    ]
    resources = ["*"]
  }
}

//Attach the above policy to an existing user
resource "aws_iam_role_policy_attachment" "emrfs_user_policy_attachment" {
  role       = "${var.aws_role_name}"
  policy_arn = "${aws_iam_policy.emrfs_user_minimal_policy.arn}"
}
