
##他のモジュールに出力

output "ALB_ARN_SUFFIX" {
  description = "Alb Arn"
  value       = aws_lb.alb.arn_suffix
}

output "ALB_TARGET_ARN_SUFFIX" {
  description = "Alb Target Arn"
  value       = aws_lb_target_group.alb_target.arn_suffix
}
