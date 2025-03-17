##他のモジュールに出力

output "EC2ID" {
  description = "EC2 ID"
  value       = aws_instance.ec2_instance.id
}

