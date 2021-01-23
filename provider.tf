terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.25"
    }
  }
}

provider "aws" {
  region = var.region
}
