locals {
  startup_script = templatefile("${path.module}/../../templates/startup_script.sh.tmpl", {
      pre_install_bash    = var.pre_install_bash
      tamr_zip_uri        = var.tamr_zip_uri
      tamr_config         = var.tamr_config_file
      tamr_home_directory = var.tamr_instance_install_directory
    })
  
  rendered_user_data = <<-EOF
  #! /bin/bash

  sudo apt-get update
  sudo apt-get install awscli postgresql -y
  sudo sysctl -w vm.max_map_count=262144

  aws s3 cp s3://${var.tamr_filesystem_bucket}/${aws_s3_bucket_object.startup_script.key} /tmp/startup_script.sh
  /bin/bash /tmp/startup_script.sh

  EOF
}

resource "aws_s3_bucket_object" "startup_script" {
  bucket = var.tamr_filesystem_bucket
  key    = "tamr_aws_startup.sh"
  content = local.startup_script
  server_side_encryption = "AES256"
}

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
  }

  metadata_options {
    http_tokens                 = var.require_http_tokens ? "required" : "optional"
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 1
  }

  user_data = data.template_cloudinit_config.bootstrap-scripts[0].rendered

  tags = var.tags
}

resource "aws_network_interface" "tamr-instance-network" {
  subnet_id       = var.subnet_id
  private_ips     = var.private_ips
  security_groups = var.security_group_ids
  tags            = var.tags
}

data "template_cloudinit_config" "bootstrap-scripts" {
  count         = length(var.bootstrap_scripts) + 1
  base64_encode = true

  dynamic "part" {
    for_each = concat(var.bootstrap_scripts, [local.rendered_user_data])
    content {
      content_type = "text/x-shellscript"
      content      = part.value
    }
  }
}
