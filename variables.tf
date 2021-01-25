variable "cidr_vpc" {
  description = "CIDR block for the VPC"
  default     = "10.1.0.0/16"
}

variable "environment_tag" {
  description = "Environment tag"
  default     = "Beeper"
}

variable "region" {
  description = "The region Terraform deploys your instance"
}

variable "ami" {
  description = "AMI image to apply"
}

variable "instance_type" {
  description = "Instance type to create"
}

variable "aws_version" {
  description = "Terraform AWS Provider version"
}

variable "server_start" {
  description = "CRON Expression to start the server"
}

variable "server_stop" {
  description = "CRON Expression to stop the server"
}

variable "instance_tcp_service_ports" {
  description = "TCP ports required by beeper"
}

variable "instance_udp_service_ports" {
  description = "TCP ports required by beeper"
}


variable "ssh_public_key" {
  description = "Public SSH key to access the EC2 instance"
}

variable "tld" {
  description = "Top Level Domain (Hosted Zone)"
}

variable "element_user" {
  description = "Admin username to access Element"
}

variable "element_password" {
  description = "Admin password to access Element"
}

variable "lets_encrypt_support_email" {
  description = "Let's Encrypt support email address"
}
