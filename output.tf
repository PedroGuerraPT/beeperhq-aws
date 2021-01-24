output "ec2_dns" {
  value = aws_instance.beeper.public_dns
}

output "elb_dns" {
  value = aws_elb.beeper-elb.dns_name
}
