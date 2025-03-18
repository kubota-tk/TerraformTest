##他のモジュールに出力

output "SnsTopicName" {
  value = aws_sns_topic.sns_topic.name
}

