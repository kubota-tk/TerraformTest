##変数は、モジュール側であっても定義
##全体に必要な変数はenvにも定義

variable "project_name" {}

variable "VPCID" {
  description = "Internet Gateway を関連付ける VPC の ID"
  type        = string
  default     = "var.VPCID"
}
