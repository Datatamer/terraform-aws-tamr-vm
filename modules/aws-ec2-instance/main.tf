resource "aws_instance" "tamr-instance" {
  ami                    = var.ami
  availability_zone      = var.availability_zone
  iam_instance_profile   = var.iam_instance_profile
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = var.security_group_ids
  subnet_id              = var.subnet_id

  root_block_device {
    volume_type = var.volume_type
    volume_size = var.volume_size
    encrypted   = var.enable_volume_encryption
  }

  user_data = length(var.bootstrap_scripts) == 0 ? "" : data.template_cloudinit_config.bootstrap-scripts[0].rendered

  tags = var.tags
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
