##子モジュール側での変数定義

##親モジュールのあるenvで設定
variable "project_name" {}
variable "aws_region" {}
variable "Instance_Type" {}
variable "Volume_Size" {}
variable "Volume_Type" {}
variable "Key_Name" {}
variable "AMI" {}

## 他モジュールのoutputで設定
variable "Pub-SubA-ID" {}
variable "Pub-SubC-ID" {}
variable "EC2-SG-ID" {}
variable "ALB-SG-ID" {}
variable "S3_Acc_Ins_Pro_Id" {}

