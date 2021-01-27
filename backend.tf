terraform {
  backend "s3" {
    encrypt = true
    bucket  = "pguerra-beeper-tf-state"
    region  = "eu-west-1"
    key     = "terraform/beeper_tf_state"
  }
}

resource "aws_s3_bucket" "pguerra-beeper-tf-state" {
  bucket = "pguerra-beeper-tf-state"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    id      = "pguerra-beeper-tf-state"
    enabled = true

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
  }
}
