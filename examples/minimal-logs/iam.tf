# Get CloudWatchAgentServerPolicy
data "aws_iam_policy" "cw-agent-server-policy" {
  arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# Attach CloudWatchAgentServerPolicy to tamr-vm
resource "aws_iam_role_policy_attachment" "cw-agent-server-policy" {
  role       = module.tamr-vm.tamr_iam_role.tamr_instance_role_name
  policy_arn = data.aws_iam_policy.cw-agent-server-policy.arn
}