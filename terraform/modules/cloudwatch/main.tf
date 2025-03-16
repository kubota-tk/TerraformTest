##アカウントID出力
data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_caller_identity" "current" {}
locals {
  account_id = data.aws_caller_identity.current.account_id
}


resource "aws_cloudwatch_metric_alarm" "alb_error_alarm" {
  alarm_name        = "${var.project_name}-${var.environment_identifier}-AlbTargetError"
  alarm_description = "AlbTargetError is more than once"
  alarm_actions     = ["arn:aws:sns:${var.aws_region}:${local.account_id}:${var.SnsTopicName}"]
  //  alarm_actions = ["arn:aws:sns:${var.aws_region}:891377211926:${var.SnsTopicName}"]
  //  alarm_actions = ["arn:aws:sns:ap-northeast-1:891377211926:${var.SnsTopicName}"]

  comparison_operator = "GreaterThanOrEqualToThreshold"
  metric_name         = "UnHealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  datapoints_to_alarm = "1"
  evaluation_periods  = "1"
  period              = "60"
  statistic           = "Sum"
  threshold           = "1"
  treat_missing_data  = "breaching"
  dimensions = {
    Name  = "TargetGroup"
    Value = var.ALB_TARGET_ARN
    Name  = "LoadBalancer"
    Value = var.ALB_ARN
    Name  = "AvailabilityZone"
    value = element(data.aws_availability_zones.available.names, 0)

##    Value = "${var.aws_region}"
  }
  tags = {
    Name = "${var.project_name}-alarm"
  }
}


