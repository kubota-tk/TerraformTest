######## availability_zone出力 ########
data "aws_availability_zones" "available" {
  state = "available"
}

######## region出力 ########
data "aws_region" "current" {}
locals {
  aws_region = data.aws_region.current.name
}

######## アカウントID出力 ########
data "aws_caller_identity" "current" {}
locals {
  account_id = data.aws_caller_identity.current.account_id
}

######## アラーム メトリック########
resource "aws_cloudwatch_metric_alarm" "alb_error_alarm" {
  alarm_name        = "${var.project_name}-${var.environment_identifier}-AlbTargetError"
  alarm_description = "AlbTargetError is more than once"
  alarm_actions     = ["arn:aws:sns:${local.aws_region}:${local.account_id}:${var.SnsTopicName}"]

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
    TargetGroup = var.ALB_TARGET_ARN_SUFFIX
    LoadBalancer = var.ALB_ARN_SUFFIX
    AvailabilityZone = element(data.aws_availability_zones.available.names, 0)
  }
  tags = {
    Name = "${var.project_name}-alarm"
  }
}


