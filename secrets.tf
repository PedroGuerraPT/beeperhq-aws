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

resource "aws_ssm_parameter" "matrix_coturn_turn_static_auth_secret" {
  name  = "matrix_coturn_turn_static_auth_secret"
  type  = "SecureString"
  value = var.matrix_coturn_turn_static_auth_secret
}

resource "aws_ssm_parameter" "matrix_synapse_macaroon_secret_key" {
  name  = "matrix_synapse_macaroon_secret_key"
  type  = "SecureString"
  value = var.matrix_synapse_macaroon_secret_key
}

resource "aws_ssm_parameter" "matrix_postgres_connection_password" {
  name  = "matrix_postgres_connection_password"
  type  = "SecureString"
  value = var.matrix_postgres_connection_password
}

resource "aws_ssm_parameter" "matrix_mailer_sender_address" {
  name  = "matrix_mailer_sender_address"
  type  = "SecureString"
  value = var.matrix_mailer_sender_address
}

resource "aws_ssm_parameter" "matrix_mailer_relay_host_port" {
  name  = "matrix_mailer_relay_host_port"
  type  = "String"
  value = var.matrix_mailer_relay_host_port
}

resource "aws_ssm_parameter" "matrix_mailer_relay_auth_username" {
  name  = "matrix_mailer_relay_auth_username"
  type  = "SecureString"
  value = var.matrix_mailer_relay_auth_username
}

resource "aws_ssm_parameter" "matrix_mailer_relay_auth_password" {
  name  = "matrix_mailer_relay_auth_password"
  type  = "SecureString"
  value = var.matrix_mailer_relay_auth_password
}

resource "aws_ssm_parameter" "matrix_synapse_ext_password_provider_shared_secret_auth_shared_secret" {
  name  = "matrix_synapse_ext_password_provider_shared_secret_auth_shared_secret"
  type  = "SecureString"
  value = var.matrix_synapse_ext_password_provider_shared_secret_auth_shared_secret
}

resource "aws_ssm_parameter" "lets_encrypt_support_email" {
  name  = "lets_encrypt_support_email"
  type  = "SecureString"
  value = var.lets_encrypt_support_email
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = aws_iam_role.secrets_role.name
}

resource "aws_iam_role" "secrets_role" {
  name               = "secrets_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_role_policy_attachment" "policy-attach" {
  role       = aws_iam_role.secrets_role.name
  policy_arn = aws_iam_policy.secrets_policy.arn
}

resource "aws_iam_policy" "secrets_policy" {
  name        = "secrets_policy"
  description = "Secrets Policy"

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "ssm:GetParameters"
        ],
        "Resource": [
          "arn:aws:ssm:*:399108506043:parameter/*"
        ]
      }
    ]
  }
EOF
}