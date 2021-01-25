resource "aws_ssm_parameter" "aws_access_key" {
  name  = "EC2_ACCESS_KEY"
  type  = "String"
  value = "AKIAVZ3FYQG546ZO6WHP"
}

resource "aws_ssm_parameter" "aws_secret_key" {
  name  = "EC2_SECRET_KEY"
  type  = "String"
  value = "lYtmQVsJzvsiFxRjeUcRl2EyWo5NUoIiBbBvEYaV"
}

resource "aws_ssm_association" "aws_access_key" {
  name = aws_ssm_parameter.aws_access_key.name

  targets {
    key    = "InstanceIds"
    values = [aws_instance.beeper.id]
  }
}

resource "aws_ssm_association" "aws_secret_key" {
  name = aws_ssm_parameter.aws_secret_key.name

  targets {
    key    = "InstanceIds"
    values = [aws_instance.beeper.id]
  }
}

resource "aws_secretsmanager_secret" "lets_encrypt_support_email" {
  name = "lets_encrypt_support_email"
}

resource "aws_secretsmanager_secret_version" "lets_encrypt_support_email" {
  secret_id     = aws_secretsmanager_secret.lets_encrypt_support_email.id
  secret_string = var.lets_encrypt_support_email
}