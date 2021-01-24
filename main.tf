resource "aws_instance" "beeper" {
  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.sg_instance.id]
  associate_public_ip_address = true
  user_data                   = data.template_file.user_data.rendered
  root_block_device {
    volume_size = 16
  }

  tags = {
    Name = "beeper"
  }
}

data "template_file" "user_data" {
  template = file("provision.tpl")
  vars = {
    "beeper_tld"          = var.tld
    "ssh_public_key"      = var.ssh_public_key
    "dimension_user"      = var.dimension_user
    "dimension_password"  = var.dimension_password
  }
}


