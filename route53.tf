resource "aws_route53_zone" "dns-zone" {
  name = var.tld
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.dns-zone.zone_id
  name    = var.tld
  type    = "A"

  alias {
    name                   = aws_elb.beeper-elb.dns_name
    zone_id                = aws_elb.beeper-elb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "matrix" {
  zone_id = aws_route53_zone.dns-zone.zone_id
  name    = "matrix.${var.tld}"
  type    = "A"

  alias {
    name                   = aws_elb.beeper-elb.dns_name
    zone_id                = aws_elb.beeper-elb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "matrix-element" {
  zone_id = aws_route53_zone.dns-zone.zone_id
  name = "element.${var.tld}"
  type = "CNAME"
  ttl = "300"
  records = [ "matrix.${var.tld}" ]
}

resource "aws_route53_record" "matrix-dimension" {
  zone_id = aws_route53_zone.dns-zone.zone_id
  name = "dimension.${var.tld}"
  type = "CNAME"
  ttl = "300"
  records = [ "matrix.${var.tld}" ]
}

resource "aws_route53_record" "matrix-tcp" {
  name    = "_matrix-identity._tcp"
  records = ["10 0 443 matrix.${var.tld}"]
  ttl     = "300"
  type    = "SRV"
  zone_id = aws_route53_zone.dns-zone.zone_id
}
