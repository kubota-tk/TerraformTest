##ルートモジュールでの変数定義
##terraform.tfvarsで値を設定

######## サービス全体 ########

variable "project_name" {
  description = "Project Name"
  type        = string
}
variable "db_username" {
  description = "DB Username"
  type        = string
}
variable "db_password" {
  description = "DB Password"
}
variable "aws_region" {
  description = "Aws Region"
  type        = string
}
variable "environment_identifier" {
  description = "environment_identifier for sns_topic"
  type        = string
  default     = "email"
}

######## vpcモジュール ########
variable "vpccidr" {}
variable "public_subnet_acidr" {}
variable "public_subnet_ccidr" {}
variable "private_subnet_acidr" {}
variable "private_subnet_ccidr" {}

######## security_group モジュール########

######## iam モジュール ########

######## ec2モジュール########
variable "Instance_Type" {}
variable "Volume_Size" {}
variable "Volume_Type" {}
variable "Key_Name" {}
variable "AMI" {}

######## s3モジュール ########

######## albモジュール ########

######## rdsモジュール ########

######## snsモジュール ########
variable "email" {}

######## cloudwatchモジュール ########


