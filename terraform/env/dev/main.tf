##各モジュールの呼び出し

module "vpc" {
  source = "../../modules/vpc"

  project_name = var.project_name

  vpccidr = "10.1.0.0/16"

  public_subnet_acidr = "10.1.10.0/24"
  public_subnet_ccidr = "10.1.20.0/24"

  private_subnet_acidr = "10.1.100.0/24"
  private_subnet_ccidr = "10.1.200.0/24"
}

module "security_group" {
  source = "../../modules/security_group"

  VPCID        = module.vpc.VPCID
  project_name = var.project_name
}


module "iam" {
  source = "../../modules/iam"

  project_name = var.project_name
  S3ID = module.s3.S3ID
}

module "ec2" {
  source = "../../modules/ec2"

  aws_region = var.aws_region

  EC2-SG-ID   = module.security_group.EC2-SG-ID
  ALB-SG-ID   = module.security_group.ALB-SG-ID
  Pub-SubA-ID = module.vpc.Pub-SubA-ID
  Pub-SubC-ID = module.vpc.Pub-SubC-ID

  //  EC2-SG-ID = aws_security_group.ec2_security_group.id
  //  ALB-SG-ID = aws_security_group.alb_security_group.id
  //  Pub-SubA-ID = aws_subnet.public_subnet_a.id
  //  Pub-SubC-ID = aws_subnet.public_subnet_c.id

  project_name = var.project_name

  S3_Acc_Ins_Pro_Id = module.iam.S3_Acc_Ins_Pro_Id

  //  S3_Acc_Ins_Pro_Id = aws_iam_instance_profile.s3_access_instance_profile.id

}

module "s3" {
  source = "../../modules/s3"

  project_name = var.project_name
}

module "alb" {
  source = "../../modules/alb"

  VPCID        = module.vpc.VPCID
  EC2ID        = module.ec2.EC2ID
  Pub-SubA-ID  = module.vpc.Pub-SubA-ID
  Pub-SubC-ID  = module.vpc.Pub-SubC-ID
  ALB-SG-ID    = module.security_group.ALB-SG-ID
  project_name = var.project_name
}

module "rds" {
  source = "../../modules/rds"

  project_name = var.project_name

  db_engine_name           = "mysql"
  my_sql_major_version     = "8.0"
  my_sql_minor_version     = "36"
  db_instance_class        = "db.t3.micro"
  db_instance_storage_size = "20"
  db_instance_storage_type = "gp2"
  db_name                  = "TerraformTestdb"

  username = var.db_username
  password = var.db_password

  Pri-SubC-ID = module.vpc.Pri-SubC-ID
  Pri-SubA-ID = module.vpc.Pri-SubA-ID
  RDS-SG-ID   = module.security_group.RDS-SG-ID
}

module "sns" {
  source = "../../modules/sns"

  project_name           = var.project_name
  environment_identifier = var.environment_identifier
  email                  = "fvqool@onetm-ml.com"
}


module "cloudwatch" {
  source = "../../modules/cloudwatch"

  project_name           = var.project_name
  aws_region             = var.aws_region
  environment_identifier = var.environment_identifier

  ALB_TARGET_ARN = module.alb.ALB_TARGET_ARN
  ALB_ARN        = module.alb.ALB_ARN
  SnsTopicName   = module.sns.SnsTopicName
}
