resource "aws_elb" "beeper-elb" {
  name    = "beeper-elb"
  availability_zones = [ "eu-west-1a", "eu-west-1b", "eu-west-1c" ]
  instances = [ aws_instance.beeper.id ]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  listener {
    instance_port      = 443
    instance_protocol  = "http"
    lb_port            = 80
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
