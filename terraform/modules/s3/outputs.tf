
##他のモジュールに出力したいもの

output "S3ID" {
  description = "S3 Bucket ID"
  value       = aws_s3_bucket.s3_bucket.id
}


