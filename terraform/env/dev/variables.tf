##本サービス全体で使う変数（変数名と型で定義）
##実際の値はterraform.tfvarsに記載
##variable,local両方併用


variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "project_name" {
  description = "Project Name"
  type = string
  default = "var.project_name"
}

variable "environment_identifier" {
  description = "Environment Identifier in SnsTopic"
  type = string
  default = "email"
}

variable "db_username" {
  description = "DB Username"
  type        = string
}

variable "db_password" {
  description = "DB Password"
  type        = string
}

//  variable "VPCID" {}
//  description = "Internet Gateway を関連付ける VPC の ID"
//  type = string
//  default = aws_vpc.vpc.id
//}

//variable "EC2-SG-ID" {
//  description = "Value in Cloudformation ID"
//  type = string
//  default = "var.EC2-SG-ID"
//}

//variable "ALB-SG-ID" {
//  description = "Value in Cloudformation ID"
//  type = string
//  default = "var.ALB-SG-ID"
//}

//variable "Pub-SubA-ID" {
//  description = "Value in Cloudformation ID"
//  type = string
//  default = "var.Pub-SubA-ID"
//}

//variable "Pub-SubC-ID" {
//  description = "Value in Cloudformation ID"
//  type = string
//  default = "var.Pub-SubC-ID"
//}

//variable "EC2ID" {
//  description = "Value in EC2 ID"
//  type = string
//  default = "var.EC2ID"
//}
