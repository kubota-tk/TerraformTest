##他のモジュールに出力

output "S3_Acc_Ins_Pro_Id" {
  value = aws_iam_role.s3_access_role.name
}
