resource "aws_cloudwatch_log_group" "tamr_log_group" {
  name = format("%s-%s", var.name-prefix, "tamr_log_group")
  tags = var.tags
}
