##他のモジュールに出力したいもの

output "SnsTopicName" {
  value = aws_sns_topic.sns_topic.name
}

