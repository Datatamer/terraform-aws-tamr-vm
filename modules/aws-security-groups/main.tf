//Security group for the Tamr EC2 instance
resource "aws_security_group" "tamr-vm-sg" {
  name        = "${var.sg_name}"
  description = "Default security group for tamr"
  vpc_id = "${var.vpc_id}"
  tags = var.additional_tags
}

// local variables to indicate whether to use CIDR blocks or security groups
locals {
  cidr_block_ingress_rule = length(var.ingress_cidr_blocks) > 0 ? 1 : 0
  security_group_ingress_rule = length(var.ingress_security_groups) > 0 ? length(var.ingress_security_groups) : 0
  cidr_block_egress_rule = length(var.egress_cidr_blocks) > 0 ? 1 : 0
  security_group_egress_rule = length(var.egress_security_groups) > 0 ? length(var.egress_security_groups) : 0
}

//security group rules for the Tamr VM security group created above

resource "aws_security_group_rule" "UI_access_cidr"{
  count = local.cidr_block_ingress_rule
  description = "Tamr UI and API access from allowed CIDR blocks"
  security_group_id = aws_security_group.tamr-vm-sg.id
  type = "ingress"
  from_port = var.tamr_ui_port
  to_port   = var.tamr_ui_port
  protocol  = "tcp"
  cidr_blocks = "${var.ingress_cidr_blocks}"
}

resource "aws_security_group_rule" "UI_access_sg"{
  count = local.security_group_ingress_rule
  description = "Tamr UI and API access from allowed CIDR blocks"
  security_group_id = aws_security_group.tamr-vm-sg.id
  type = "ingress"
  from_port = var.tamr_ui_port
  to_port   = var.tamr_ui_port
  protocol  = "tcp"
  source_security_group_id = var.ingress_security_groups[count.index]
}

resource "aws_security_group_rule" "ES_access_cidr"{
  count = local.cidr_block_ingress_rule
  description = "Tamr elasticsearch access from allowed CIDR blocks"
  security_group_id = aws_security_group.tamr-vm-sg.id
  type = "ingress"
  from_port = var.tamr_es_port
  to_port   = var.tamr_es_port
  protocol  = "tcp"
  cidr_blocks = "${var.ingress_cidr_blocks}"
}

resource "aws_security_group_rule" "ES_access_sg"{
  count = local.security_group_ingress_rule
  description = "Tamr elasticsearch access from allowed CIDR blocks"
  security_group_id = aws_security_group.tamr-vm-sg.id
  type = "ingress"
  from_port = var.tamr_es_port
  to_port   = var.tamr_es_port
  protocol  = "tcp"
  source_security_group_id = var.ingress_security_groups[count.index]
}

resource "aws_security_group_rule" "auth_access_cidr"{
  count = local.cidr_block_ingress_rule
  description = "Tamr auth access from allowed CIDR blocks"
  security_group_id = aws_security_group.tamr-vm-sg.id
  type = "ingress"
  from_port = var.tamr_auth_port
  to_port   = var.tamr_auth_port
  protocol  = "tcp"
  cidr_blocks = "${var.ingress_cidr_blocks}"
}

resource "aws_security_group_rule" "auth_access_sg"{
  count = local.security_group_ingress_rule
  description = "Tamr auth access from allowed CIDR blocks"
  security_group_id = aws_security_group.tamr-vm-sg.id
  type = "ingress"
  from_port = var.tamr_auth_port
  to_port   = var.tamr_auth_port
  protocol  = "tcp"
  source_security_group_id = var.ingress_security_groups[count.index]
}

resource "aws_security_group_rule" "persistence_access_cidr"{
  count = local.cidr_block_ingress_rule
  description = "Tamr persistence access from allowed CIDR blocks"
  security_group_id = aws_security_group.tamr-vm-sg.id
  type = "ingress"
  from_port = var.tamr_persistence_port
  to_port   = var.tamr_persistence_port
  protocol  = "tcp"
  cidr_blocks = "${var.ingress_cidr_blocks}"
}

resource "aws_security_group_rule" "persistence_access_sg"{
  count = local.security_group_ingress_rule
  description = "Tamr persistence access from allowed CIDR blocks"
  security_group_id = aws_security_group.tamr-vm-sg.id
  type = "ingress"
  from_port = var.tamr_persistence_port
  to_port   = var.tamr_persistence_port
  protocol  = "tcp"
  source_security_group_id = var.ingress_security_groups[count.index]
}

resource "aws_security_group_rule" "zk_access_cidr"{
  count = local.cidr_block_ingress_rule
  description = "Zookeeper access from allowed CIDR blocks"
  security_group_id = aws_security_group.tamr-vm-sg.id
  type = "ingress"
  from_port = var.zk_port
  to_port   = var.zk_port
  protocol  = "tcp"
  cidr_blocks = "${var.ingress_cidr_blocks}"
}

resource "aws_security_group_rule" "zk_access_sg"{
  count = local.security_group_ingress_rule
  description = "Zookeeper access from allowed CIDR blocks"
  security_group_id = aws_security_group.tamr-vm-sg.id
  type = "ingress"
  from_port = var.zk_port
  to_port   = var.zk_port
  protocol  = "tcp"
  source_security_group_id = var.ingress_security_groups[count.index]
}

resource "aws_security_group_rule" "kibana_access_cidr"{
  count = var.enable_ssh && (local.cidr_block_ingress_rule > 0 ? true : false ) ? 1 : 0
  security_group_id = aws_security_group.tamr-vm-sg.id
  type = "ingress"
  description = "Kibana port"
  from_port = var.kibana_port
  to_port   = var.kibana_port
  protocol  = "tcp"
  cidr_blocks = "${var.ingress_cidr_blocks}"
}

resource "aws_security_group_rule" "kibana_access_sg"{
  count = var.enable_ssh && (local.security_group_ingress_rule > 0 ? true : false ) ? 1 : 0
  security_group_id = aws_security_group.tamr-vm-sg.id
  type = "ingress"
  description = "Kibana port"
  from_port = var.kibana_port
  to_port   = var.kibana_port
  protocol  = "tcp"
  source_security_group_id = var.ingress_security_groups[count.index]
}

resource "aws_security_group_rule" "grafana_access_cidr"{
  count = var.enable_ssh && (local.cidr_block_ingress_rule > 0 ? true : false ) ? 1 : 0
  security_group_id = aws_security_group.tamr-vm-sg.id
  type = "ingress"
  description = "Grafana port"
  from_port = var.grafana_port
  to_port   = var.grafana_port
  protocol  = "tcp"
  cidr_blocks = "${var.ingress_cidr_blocks}"
}

resource "aws_security_group_rule" "grafana_access_sg"{
  count = var.enable_ssh && (local.security_group_ingress_rule > 0 ? true : false ) ? 1 : 0
  security_group_id = aws_security_group.tamr-vm-sg.id
  type = "ingress"
  description = "Grafana port"
  from_port = var.grafana_port
  to_port   = var.grafana_port
  protocol  = "tcp"
  source_security_group_id = var.ingress_security_groups[count.index]
}

resource "aws_security_group_rule" "tls_access_cidr"{
  count = local.cidr_block_ingress_rule
  security_group_id = aws_security_group.tamr-vm-sg.id
  type = "ingress"
  description = "TLS from allowed CIDR blocks"
  from_port = 443
  to_port   = 443
  protocol  = "tcp"
  cidr_blocks = "${var.ingress_cidr_blocks}"
}

resource "aws_security_group_rule" "tls_access_sg"{
  count = local.security_group_ingress_rule
  security_group_id = aws_security_group.tamr-vm-sg.id
  type = "ingress"
  description = "TLS from allowed CIDR blocks"
  from_port = 443
  to_port   = 443
  protocol  = "tcp"
  source_security_group_id = var.ingress_security_groups[count.index]
}

resource "aws_security_group_rule" "ssh_access_cidr"{
  count = var.enable_ssh && (local.cidr_block_ingress_rule > 0 ? true : false ) ? 1 : 0
  security_group_id = aws_security_group.tamr-vm-sg.id
  type = "ingress"
  description = "SSH from allowed CIDR blocks"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = "${var.ingress_cidr_blocks}"
}

resource "aws_security_group_rule" "ssh_access_sg"{
  count = var.enable_ssh && (local.security_group_ingress_rule > 0 ? true : false ) ? 1 : 0
  security_group_id = aws_security_group.tamr-vm-sg.id
  type = "ingress"
  description = "SSH from allowed CIDR blocks"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  source_security_group_id = var.ingress_security_groups[count.index]
}

resource "aws_security_group_rule" "ping_access_cidr"{
  count = var.enable_ssh && (local.cidr_block_ingress_rule > 0 ? true : false ) ? 1 : 0
  security_group_id = aws_security_group.tamr-vm-sg.id
  type = "ingress"
  description = "Ping from allowed CIDR blocks"
  from_port   = -1
  to_port     = -1
  protocol    = "icmp"
  cidr_blocks = "${var.ingress_cidr_blocks}"
}

resource "aws_security_group_rule" "ping_access_sg"{
  count = var.enable_ssh && (local.security_group_ingress_rule > 0 ? true : false ) ? 1 : 0
  security_group_id = aws_security_group.tamr-vm-sg.id
  type = "ingress"
  description = "Ping from allowed CIDR blocks"
  from_port   = -1
  to_port     = -1
  protocol    = "icmp"
  source_security_group_id = var.ingress_security_groups[count.index]
}

resource "aws_security_group_rule" "http_access_cidr"{
  count = local.cidr_block_ingress_rule
  security_group_id = aws_security_group.tamr-vm-sg.id
  type = "ingress"
  description = "HTTP from allowed CIDR blocks"
  from_port = 80
  to_port   = 80
  protocol  = "tcp"
  cidr_blocks = "${var.ingress_cidr_blocks}"
}

resource "aws_security_group_rule" "http_access_sg"{
  count = local.security_group_ingress_rule
  security_group_id = aws_security_group.tamr-vm-sg.id
  type = "ingress"
  description = "HTTP from allowed CIDR blocks"
  from_port = 80
  to_port   = 80
  protocol  = "tcp"
  source_security_group_id = var.ingress_security_groups[count.index]
}

resource "aws_security_group_rule" "default_egress_cidr" {
  count = local.cidr_block_egress_rule
  security_group_id = aws_security_group.tamr-vm-sg.id
  type = "egress"
  description = "Egress opening, needed for Tamr services to talk to themselves. Recreates AWS ALLOW ALL egress rule"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = "${var.egress_cidr_blocks}"
}

resource "aws_security_group_rule" "default_egress_sg"{
  count = local.security_group_egress_rule
  security_group_id = aws_security_group.tamr-vm-sg.id
  type = "egress"
  description = "Egress opening, needed for Tamr services to talk to themselves. Recreates AWS ALLOW ALL egress rule"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  source_security_group_id = var.egress_security_groups[count.index]
}
