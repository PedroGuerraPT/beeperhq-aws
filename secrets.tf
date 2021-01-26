

resource "aws_secretsmanager_secret" "matrix_coturn_turn_static_auth_secret" {
  name = "matrix_coturn_turn_static_auth_secret"
}

resource "aws_secretsmanager_secret_version" "matrix_coturn_turn_static_auth_secret" {
  secret_id     = aws_secretsmanager_secret.matrix_coturn_turn_static_auth_secret.id
  secret_string = var.matrix_coturn_turn_static_auth_secret
}

resource "aws_secretsmanager_secret" "matrix_synapse_macaroon_secret_key" {
  name = "matrix_synapse_macaroon_secret_key"
}

resource "aws_secretsmanager_secret_version" "matrix_synapse_macaroon_secret_key" {
  secret_id     = aws_secretsmanager_secret.matrix_synapse_macaroon_secret_key.id
  secret_string = var.matrix_synapse_macaroon_secret_key
}

resource "aws_secretsmanager_secret" "matrix_postgres_connection_password" {
  name = "matrix_postgres_connection_password"
}

resource "aws_secretsmanager_secret_version" "matrix_postgres_connection_password" {
  secret_id     = aws_secretsmanager_secret.matrix_postgres_connection_password.id
  secret_string = var.matrix_postgres_connection_password
}

resource "aws_secretsmanager_secret" "matrix_mailer_sender_address" {
  name = "matrix_mailer_sender_address"
}

resource "aws_secretsmanager_secret_version" "matrix_mailer_sender_address" {
  secret_id     = aws_secretsmanager_secret.matrix_mailer_sender_address.id
  secret_string = var.matrix_mailer_sender_address
}

resource "aws_secretsmanager_secret" "matrix_mailer_relay_host_port" {
  name = "matrix_mailer_relay_host_port"
}

resource "aws_secretsmanager_secret_version" "matrix_mailer_relay_host_port" {
  secret_id     = aws_secretsmanager_secret.matrix_mailer_relay_host_port.id
  secret_string = var.matrix_mailer_relay_host_port
}

resource "aws_secretsmanager_secret" "matrix_mailer_relay_auth_username" {
  name = "matrix_mailer_relay_auth_username"
}

resource "aws_secretsmanager_secret_version" "matrix_mailer_relay_auth_username" {
  secret_id     = aws_secretsmanager_secret.matrix_mailer_relay_auth_username.id
  secret_string = var.matrix_mailer_relay_auth_username
}

resource "aws_secretsmanager_secret" "matrix_mailer_relay_auth_password" {
  name = "matrix_mailer_relay_auth_password"
}

resource "aws_secretsmanager_secret_version" "matrix_mailer_relay_auth_password" {
  secret_id     = aws_secretsmanager_secret.matrix_mailer_relay_auth_password.id
  secret_string = var.matrix_mailer_relay_auth_password
}

resource "aws_secretsmanager_secret" "matrix_synapse_ext_password_provider_shared_secret_auth_shared_secret" {
  name = "matrix_synapse_ext_password_provider_shared_secret_auth_shared_secret"
}

resource "aws_secretsmanager_secret_version" "matrix_synapse_ext_password_provider_shared_secret_auth_shared_secret" {
  secret_id     = aws_secretsmanager_secret.matrix_synapse_ext_password_provider_shared_secret_auth_shared_secret.id
  secret_string = var.matrix_synapse_ext_password_provider_shared_secret_auth_shared_secret
}

resource "aws_ssm_parameter" "ec2_secret_key" {
  name  = "EC2_SECRET_KEY"
  type  = "SecureString"
  value = var.ec2_secret_key
}

resource "aws_ssm_parameter" "ec2_access_key" {
  name  = "EC2_ACCESS_KEY"
  type  = "SecureString"
  value = var.ec2_access_key
}

resource "aws_ssm_parameter" "ec2_region" {
  name  = "EC2_REGION"
  type  = "String"
  value = var.region
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = aws_iam_role.secrets_role.name
}

resource "aws_iam_role" "secrets_role" {
  name = "secrets_role"
  path = "/"

  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "ssm:GetParameters"
        ],
        "Resource": [
          "arn:aws:ssm:eu-west-1:399108506043:parameter/EC2_SECRET_KEY",
          "arn:aws:ssm:eu-west-1:399108506043:parameter/EC2_ACCESS_KEY",
          "arn:aws:ssm:eu-west-1:399108506043:parameter/EC2_REGION"
        ]
      }
    ]
  }
EOF
}