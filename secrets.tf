resource "aws_secretsmanager_secret" "lets_encrypt_support_email" {
  name = "lets_encrypt_support_email"
}

resource "aws_secretsmanager_secret_version" "lets_encrypt_support_email" {
  secret_id     = aws_secretsmanager_secret.lets_encrypt_support_email.id
  secret_string = var.lets_encrypt_support_email
}