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

  tags = var.additional_tags
}
