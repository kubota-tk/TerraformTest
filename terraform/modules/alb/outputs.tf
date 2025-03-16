
##他のモジュールに出力したいもの

//output "AlbDnsName" {
//  description = "DNS-Name of ALB"
//  value = aws_lb.alb.domain_name
//}


output "ALB_ARN" {
  description = "Alb Arn"
  value = aws_lb.alb.arn
}

output "ALB_TARGET_ARN" {
  description = "Alb Target Arn"
  value = aws_lb_target_group.alb_target.arn
}
