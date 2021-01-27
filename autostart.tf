module "start_ec2_instance" {
  source                         = "diodonfrost/lambda-scheduler-stop-start/aws"
  name                           = "ec2_start"
  cloudwatch_schedule_expression = var.server_start
  schedule_action                = "start"
  autoscaling_schedule           = "false"
  ec2_schedule                   = "true"
  rds_schedule                   = "false"
  resources_tag = {
    key   = "tostop"
    value = "true"
  }
}

module "stop_ec2_instance" {
  source                         = "diodonfrost/lambda-scheduler-stop-start/aws"
  name                           = "ec2_stop"
  cloudwatch_schedule_expression = var.server_stop
  schedule_action                = "stop"
  autoscaling_schedule           = "false"
  ec2_schedule                   = "true"
  rds_schedule                   = "false"
  resources_tag = {
    key   = "tostop"
    value = "true"
  }
}
