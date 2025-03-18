##子モジュール側での変数定義

##親モジュールのあるenvで設定
variable "project_name" {}
variable "aws_region" {}
variable "environment_identifier" {}

##他モジュールのoutputで設定
variable "SnsTopicName" {}
variable "ALB_ARN_SUFFIX" {}
variable "ALB_TARGET_ARN_SUFFIX" {}

