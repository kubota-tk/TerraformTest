######## EC2のセキュリティグループ ########
resource "aws_security_group" "ec2_security_group" {
  name        = "${var.project_name}-ec2-sg"
  description = "Allow connections from SSH and ALB"
  vpc_id      = var.VPCID

  ingress = [
    {
      description      = "SSH"
      protocol         = "tcp"
      from_port        = 22
      to_port          = 22
      cidr_blocks      = ["0.0.0.0/0"]    #Circleci無料版の仕様のため、全てのIP許可とする
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      description      = "HTTP"
      protocol         = "tcp"
      from_port        = 80
      to_port          = 80
      cidr_blocks      = []
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = [aws_security_group.alb_security_group.id]
      self = false
    }
  ]
  egress = [
    {
      description      = "for all outgoing traffics"
      from_port        = 0
      to_port          = 0
      protocol         = -1
      cidr_blocks      = ["0.0.0.0/0"]   #Circleci無料版の仕様のため、全てのIP許可とする
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]
  tags = {
    Name = "${var.project_name}-ec2-sg"
  }
}

########RDSのセキュリティグループ########
resource "aws_security_group" "rds_security_group" {
  name        = "${var.project_name}-rds-sg"
  description = "Allow connection from EC2"
  vpc_id      = var.VPCID
  ingress {
    protocol        = "tcp"
    from_port       = 3306
    to_port         = 3306
    security_groups = [aws_security_group.ec2_security_group.id]
  }
  tags = {
    Name = "${var.project_name}-rds-sg"
  }
}

########ALBのセキュリティグループ########
resource "aws_security_group" "alb_security_group" {
  name        = "${var.project_name}-alb-sg"
  description = "Allow connection from Port80"
  vpc_id      = var.VPCID
  ingress = [
    {
      description      = "HTTP"
      protocol         = "tcp"
      from_port        = 80
      to_port          = 80
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]
  egress = [
    {
      description      = "for all outgoing traffics"
      from_port        = 0
      to_port          = 0
      protocol         = -1
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]
  tags = {
    Name = "${var.project_name}-alb-sg"
  }
}


