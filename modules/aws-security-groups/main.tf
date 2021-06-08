locals {
  num_rules_ingress_sg   = length(var.ports) * length(var.ingress_security_groups)
  num_rules_ingress_cidr = length(var.ports) * length(var.ingress_cidr_blocks)
  num_rules_egress_sg    = length(var.egress_security_groups)
  num_rules_egress_cidr  = length(var.egress_cidr_blocks)

  num_security_groups_ingress_sg   = ceil(local.num_rules_ingress_sg / var.maximum_rules_per_sg)
  num_security_groups_ingress_cidr = ceil(local.num_rules_ingress_cidr / var.maximum_rules_per_sg)
  num_security_groups_egress_sg    = ceil(local.num_rules_egress_sg / var.maximum_rules_per_sg)
  num_security_groups_egress_cidr  = ceil(local.num_rules_egress_cidr / var.maximum_rules_per_sg)
}

// Ingress security groups
resource "aws_security_group" "security-groups-ingress-cidr" {
  count       = local.num_security_groups_ingress_cidr
  name        = format("%s-ingress-cidr-%s", var.sg_name, count.index)
  description = "Ingress security group for Tamr (CIDR)"
  vpc_id      = var.vpc_id
  tags        = var.additional_tags
}

resource "aws_security_group" "security-groups-ingress-sg" {
  count       = local.num_security_groups_ingress_sg
  name        = format("%s-ingress-sg-%s", var.sg_name, count.index)
  description = "Ingress security group for Tamr (SG)"
  vpc_id      = var.vpc_id
  tags        = var.additional_tags
}

// Egress security groups
resource "aws_security_group" "security-groups-egress-cidr" {
  count       = local.num_security_groups_egress_cidr
  name        = format("%s-egress-cidr-%s", var.sg_name, count.index)
  description = "Egress security group for Tamr (CIDR)"
  vpc_id      = var.vpc_id
  tags        = var.additional_tags
}

resource "aws_security_group" "security-groups-egress-sg" {
  count       = local.num_security_groups_egress_sg
  name        = format("%s-egress-sg-%s", var.sg_name, count.index)
  description = "Egress security group for Tamr (SG)"
  vpc_id      = var.vpc_id
  tags        = var.additional_tags
}

// Ingress Rules
resource "aws_security_group_rule" "ingress_cidr_rules" {
  count             = local.num_rules_ingress_cidr
  description       = format("Tamr ingress CIDR rule %s for port %s", count.index, var.ports[(count.index % length(var.ports))])
  security_group_id = aws_security_group.security-groups-ingress-cidr[(count.index % length(aws_security_group.security-groups-ingress-cidr))].id
  type              = "ingress"
  from_port         = var.ports[(count.index % length(var.ports))]
  to_port           = var.ports[(count.index % length(var.ports))]
  protocol          = "tcp"
  cidr_blocks       = [var.ingress_cidr_blocks[(count.index % length(var.ingress_cidr_blocks))]]
}

resource "aws_security_group_rule" "ingress_sg_rules" {
  count                    = local.num_rules_ingress_sg
  description              = format("Tamr ingress SG rule %s", count.index)
  security_group_id        = aws_security_group.security-groups-ingress-sg[(count.index % length(aws_security_group.security-groups-ingress-sg))].id
  type                     = "ingress"
  from_port                = var.ports[(count.index % length(var.ports))]
  to_port                  = var.ports[(count.index % length(var.ports))]
  protocol                 = "tcp"
  source_security_group_id = var.ingress_security_groups[(count.index % length(var.ingress_security_groups))]
}

// Egress Rules

resource "aws_security_group_rule" "egress_cidr_rules" {
  count             = local.num_security_groups_egress_cidr
  description       = format("Tamr egress CIDR rule %s", count.index)
  security_group_id = aws_security_group.security-groups-egress-cidr[(count.index % length(aws_security_group.security-groups-egress-cidr))].id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "tcp"
  cidr_blocks       = [var.egress_cidr_blocks[(count.index % length(var.egress_cidr_blocks))]]
}

resource "aws_security_group_rule" "egress_sg_rules" {
  count                    = local.num_rules_egress_sg
  description              = format("Tamr egress SG rule %s", count.index)
  security_group_id        = aws_security_group.security-groups-egress-sg[(count.index % length(aws_security_group.security-groups-egress-sg))].id
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "tcp"
  source_security_group_id = var.egress_security_groups[(count.index % length(var.egress_security_groups))]
}
