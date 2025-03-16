##他のモジュールに出力したいもの

output "EC2ID" {
  description = "EC2 ID"
  value       = aws_instance.ec2_instance.id
}

