##dev,prodと開発環境ごとに分けた場合を想定
##環境ごとに異なる変数を記載
##region,pass,usernameは環境変数を参照

######## サービス全体 ########
project_name = "TerraformTest"
environment_identifier = "email" ##snsトピックの識別子

######## vpcモジュール ########
vpccidr = "10.1.0.0/16"
public_subnet_acidr = "10.1.10.0/24"
public_subnet_ccidr = "10.1.20.0/24"
private_subnet_acidr = "10.1.100.0/24"
private_subnet_ccidr = "10.1.200.0/24"

######## security_group モジュール########

######## iam モジュール ########

######## ec2モジュール########
Instance_Type = "t2.micro"
Volume_Size = "8"
Volume_Type = "gp2"
Key_Name = "TerraformTest-keypair"
AMI = "amzn2-ami-kernel-5.10-hvm-2.0.20240816.0-x86_64-gp2"

######## s3モジュール ########

######## albモジュール ########

######## rdsモジュール ########

######## snsモジュール ########
email = "fvqool@onetm-ml.com"

######## cloudwatchモジュール ########



