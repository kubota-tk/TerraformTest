######## s3バケット #########
resource "aws_s3_bucket" "s3_bucket" {
  bucket = "terraformtest-s3-bucket"
  tags = {
    Name = "${var.project_name}-s3-bucket"
  }
}

######## publick access ########
resource "aws_s3_bucket_public_access_block" "s3_bucket" {
  bucket                  = aws_s3_bucket.s3_bucket.bucket
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

######## 暗号化 ########
resource "aws_s3_bucket_server_side_encryption_configuration" "s3-encryption" {
  bucket = aws_s3_bucket.s3_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}


##<<参考>> バージョニング設定
##resource "aws_s3_bucket_versioning" "s3_versioning" {
##  bucket = aws_s3_bucket.s3_bucket.id
##  versioning_configuration {
##    status = "Disabled"
##  }
##}



