
##他のモジュールに出力したいもの

output "EC2-SG-ID" {
  description = "EC2SecurityGroup ID"
  value       = aws_security_group.ec2_security_group.id
}

output "RDS-SG-ID" {
  description = "RDSSecurityGroup ID"
  value       = aws_security_group.rds_security_group.id
}

output "ALB-SG-ID" {
  description = "ALBSecurityGroup ID"
  value       = aws_security_group.alb_security_group.id
}

