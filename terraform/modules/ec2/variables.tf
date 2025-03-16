variable "project_name" {}

variable "aws_region" {}

variable "Instance_Type" {
  type    = string
  default = "t2.micro"
}

variable "Volume_Size" {
  type    = string
  default = "8"
}

variable "Volume_Type" {
  type    = string
  default = "gp2"
}

variable "S3_Acc_Ins_Pro_Id" {}

variable "Key_Name" {
  description = "The EC2 Key Pair to allow SSH"
  type        = string
  default     = "TerraformTest-keypair"
}

variable "AMI" {
  type    = string
  default = "amzn2-ami-kernel-5.10-hvm-2.0.20240816.0-x86_64-gp2"
}

variable "Pub-SubA-ID" {}

variable "Pub-SubC-ID" {}

variable "EC2-SG-ID" {}

variable "ALB-SG-ID" {}




