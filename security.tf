resource "aws_security_group" "sg_instance" {
  name   = "sg_instance"

  dynamic "ingress" {
    for_each = var.instance_tcp_service_ports
    content {
      from_port = ingress.value
      to_port   = ingress.value
      protocol  = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "ingress" {
    for_each = var.instance_udp_service_ports
    content {
      from_port = ingress.value
      to_port   = ingress.value
      protocol  = "udp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
