//Security group for the Tamr EC2 instance
resource "aws_security_group" "tamr-vm-sg" {
  name        = "${var.sg_name}"
  description = "Default security group for tamr"

  vpc_id = "${var.vpc_id}"

  tags = merge(
    {Author :"Tamr"},
    {Name: "Tamr VM SG"},
    var.additional_tags
  )

}

//security group rules for the Tamr VM security group created above

resource "aws_security_group_rule" "UI_access"{
  description = "Tamr UI and API access from allowed CIDR blocks"
  security_group_id = aws_security_group.tamr-vm-sg.id
  type = "ingress"
  from_port = var.tamr_port
  to_port   = var.tamr_port
  protocol  = "tcp"
  cidr_blocks = "${var.ingress_cidr_blocks}"
}

resource "aws_security_group_rule" "kibana_access"{
  count = var.enable_kibana_port ? 1 : 0
  security_group_id = aws_security_group.tamr-vm-sg.id
  type = "ingress"
  description = "Kibana port"
  from_port = var.kibana_port
  to_port   = var.kibana_port
  protocol  = "tcp"
  cidr_blocks = "${var.ingress_cidr_blocks}"
}

resource "aws_security_group_rule" "grafana_access"{
  count = var.enable_grafana_port ? 1 : 0
  security_group_id = aws_security_group.tamr-vm-sg.id
  type = "ingress"
  description = "Grafana port"
  from_port = var.grafana_port
  to_port   = var.grafana_port
  protocol  = "tcp"
  cidr_blocks = "${var.ingress_cidr_blocks}"
}

resource "aws_security_group_rule" "tls_access"{
  security_group_id = aws_security_group.tamr-vm-sg.id
  type = "ingress"
  description = "TLS from allowed CIDR blocks"
  from_port = 443
  to_port   = 443
  protocol  = "tcp"
  cidr_blocks = "${var.ingress_cidr_blocks}"
}

resource "aws_security_group_rule" "ssh_access"{
  count = var.enable_ssh ? 1 : 0
  security_group_id = aws_security_group.tamr-vm-sg.id
  type = "ingress"
  description = "SSH from allowed CIDR blocks"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = "${var.ingress_cidr_blocks}"
}

resource "aws_security_group_rule" "ping_access"{
  count = var.enable_ping ? 1 : 0
  security_group_id = aws_security_group.tamr-vm-sg.id
  type = "ingress"
  description = "Ping from allowed CIDR blocks"
  from_port   = -1
  to_port     = -1
  protocol    = "icmp"
  cidr_blocks = "${var.ingress_cidr_blocks}"
}

resource "aws_security_group_rule" "http_access"{
  security_group_id = aws_security_group.tamr-vm-sg.id
  type = "ingress"
  description = "HTTP from allowed CIDR blocks"
  from_port = 80
  to_port   = 80
  protocol  = "tcp"
  cidr_blocks = "${var.ingress_cidr_blocks}"
}

resource "aws_security_group_rule" "default_egress"{
  security_group_id = aws_security_group.tamr-vm-sg.id
  type = "egress"
  description = "Egress opening, needed for Tamr services to talk to themselves. Recreates AWS ALLOW ALL egress rule"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = "${var.egress_cidr_blocks}"
}
