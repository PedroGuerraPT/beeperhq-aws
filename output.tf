output "ec2_dns" {
  value = aws_instance.beeper.public_dns
}
