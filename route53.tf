resource "aws_route53_zone" "dns-zone" {
  name = var.tld
}

resource "aws_route53_record" "matrix" {
  zone_id = aws_route53_zone.dns-zone.zone_id
  name = "matrix.${var.tld}"
  type = "CNAME"
  ttl = "300"
  records = [aws_elb.beeper-elb.dns_name]
}

resource "aws_route53_record" "matrix-element" {
  zone_id = aws_route53_zone.dns-zone.zone_id
  name = "element.${var.tld}"
  type = "CNAME"
  ttl = "300"
  records = [aws_elb.beeper-elb.dns_name]
}

resource "aws_route53_record" "matrix-tcp" {
  name    = "_matrix-identity._tcp"
  records = ["10 0 443 ${aws_route53_record.matrix.name}"]
  ttl     = "300"
  type    = "SRV"
  zone_id = aws_route53_zone.dns-zone.zone_id
}
