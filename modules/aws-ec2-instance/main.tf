resource "aws_instance" "tamr-instance" {
  ami                  = var.ami
  availability_zone    = var.availability_zone
  iam_instance_profile = var.iam_instance_profile
  instance_type        = var.instance_type
  key_name             = var.key_name

  root_block_device {
    volume_type = var.volume_type
    volume_size = var.volume_size
    encrypted   = var.enable_volume_encryption
    tags        = var.tags
  }

  network_interface {
    network_interface_id = aws_network_interface.tamr-instance-network.id
    device_index         = 0
    private_ips = var.private_ips
  }

  user_data = length(var.bootstrap_scripts) == 0 ? "" : data.template_cloudinit_config.bootstrap-scripts[0].rendered

  tags = var.tags
}

resource "aws_network_interface" "tamr-instance-network" {
  subnet_id       = var.subnet_id
  security_groups = var.security_group_ids
  tags            = var.tags
}

data "template_cloudinit_config" "bootstrap-scripts" {
  count         = length(var.bootstrap_scripts)
  base64_encode = true

  dynamic "part" {
    for_each = var.bootstrap_scripts
    content {
      content_type = "text/x-shellscript"
      content      = part.value
    }
  }
}
