resource "aws_elb" "beeper-elb" {
  name    = "beeper-elb"
  availability_zones = [ "eu-west-1a", "eu-west-1b", "eu-west-1c" ]
  instances = [ aws_instance.beeper.id ]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400
  security_groups             = [ aws_security_group.sg_lb.id ]

  listener {
    instance_port      = 81
    instance_protocol  = "http"
    lb_port            = 80
    lb_protocol        = "https"
    ssl_certificate_id = aws_acm_certificate.elb_cert.id
  }

  listener {
    instance_port      = 8448
    instance_protocol  = "http"
    lb_port            = 8449
    lb_protocol        = "https"
    ssl_certificate_id = aws_acm_certificate.elb_cert.id
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  tags = {
    Name = "beeper-elb"
  }
}
