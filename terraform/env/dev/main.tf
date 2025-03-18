##各モジュールの呼び出し

######## vpcモジュール ########
module "vpc" {
  source        = "../../modules/vpc"
  project_name  = var.project_name
  vpccidr       = var.vpccidr
  public_subnet_acidr  = var.public_subnet_acidr
  public_subnet_ccidr  = var.public_subnet_ccidr
  private_subnet_acidr = var.private_subnet_acidr
  private_subnet_ccidr = var.private_subnet_ccidr
}

######## security_group モジュール########
module "security_group" {
  source = "../../modules/security_group"
  VPCID         = module.vpc.VPCID
  project_name  = var.project_name
}

######## iam モジュール ########
module "iam" {
  source = "../../modules/iam"
  project_name  = var.project_name
  S3ID          = module.s3.S3ID
}

######## ec2モジュール########
module "ec2" {
  source = "../../modules/ec2"
  project_name      = var.project_name
  aws_region        = var.aws_region
  Instance_Type     = var.Instance_Type
  Volume_Size       = var.Volume_Size
  Volume_Type       = var.Volume_Type
  Key_Name          = var.Key_Name
  AMI               = var.AMI
  EC2-SG-ID     = module.security_group.EC2-SG-ID
  ALB-SG-ID     = module.security_group.ALB-SG-ID
  Pub-SubA-ID   = module.vpc.Pub-SubA-ID
  Pub-SubC-ID   = module.vpc.Pub-SubC-ID
  S3_Acc_Ins_Pro_Id = module.iam.S3_Acc_Ins_Pro_Id

}

######## s3モジュール ########
module "s3" {
  source = "../../modules/s3"
  project_name = var.project_name
}

######## albモジュール ########
module "alb" {
  source = "../../modules/alb"
  project_name = var.project_name
  VPCID        = module.vpc.VPCID
  EC2ID        = module.ec2.EC2ID
  Pub-SubA-ID  = module.vpc.Pub-SubA-ID
  Pub-SubC-ID  = module.vpc.Pub-SubC-ID
  ALB-SG-ID    = module.security_group.ALB-SG-ID
}

######## rdsモジュール ########
module "rds" {
  source = "../../modules/rds"
  username = var.db_username
  password = var.db_password
  project_name = var.project_name
  db_engine_name           = "mysql"
  my_sql_major_version     = "8.0"
  my_sql_minor_version     = "36"
  db_instance_class        = "db.t3.micro"
  db_instance_storage_size = "20"
  db_instance_storage_type = "gp2"
  db_name                  = "TerraformTestdb"
  Pri-SubC-ID = module.vpc.Pri-SubC-ID
  Pri-SubA-ID = module.vpc.Pri-SubA-ID
  RDS-SG-ID   = module.security_group.RDS-SG-ID
}

######## snsモジュール ########
module "sns" {
  source = "../../modules/sns"
  project_name           = var.project_name
  email                  = var.email
  environment_identifier = var.environment_identifier
}

######## cloudwatchモジュール ########
module "cloudwatch" {
  source = "../../modules/cloudwatch"
  project_name           = var.project_name
  aws_region             = var.aws_region
  environment_identifier = var.environment_identifier
  ALB_TARGET_ARN = module.alb.ALB_TARGET_ARN
  ALB_ARN        = module.alb.ALB_ARN
  SnsTopicName   = module.sns.SnsTopicName
}
