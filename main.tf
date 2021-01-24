resource "aws_instance" "beeper" {
  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.sg_01.id]
  associate_public_ip_address = true
  user_data                   = data.template_file.user_data.rendered

  tags = {
    Name = "beeper"
  }
}

data "template_file" "user_data" {
  template = file("provision.tpl")
  vars = {
    "beeper_dns" = var.tld
    "ssh_public_key" = var.ssh_public_key
  }
}

output "ec2_dns" {
  value = aws_instance.beeper.public_dns
}
