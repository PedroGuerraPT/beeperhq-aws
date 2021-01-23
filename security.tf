resource "aws_security_group" "sg_01" {
  name   = "sg_01"
  vpc_id = aws_vpc.vpc.id


  dynamic "ingress" {
    for_each = var.tcp_service_ports
    content {
      from_port = ingress.value
      to_port   = ingress.value
      protocol  = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "ingress" {
    for_each = var.udp_service_ports
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

resource "aws_acm_certificate" "elb_cert" {
  domain_name       = aws_route53_zone.dns-zone.name
  validation_method = "DNS"

  tags = {
    Environment = var.environment_tag
  }

  lifecycle {
    create_before_destroy = true
  }
}
