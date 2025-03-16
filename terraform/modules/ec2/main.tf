resource "aws_network_interface" "ec2_network_interface" {
    subnet_id = var.Pub-SubA-ID
}

// resource "aws_ami" "origin_base"{
//   name = var.AMI
//   root_device_name = "/dev/xvda"
//}

resource "aws_instance" "ec2_instance" {
//  ami                         = aws_ami.origin_base.name 
  ami                         = "ami-031ff5a575101728a"
  instance_type               = var.Instance_Type
  subnet_id                   = var.Pub-SubA-ID
  iam_instance_profile        = var.S3_Acc_Ins_Pro_Id
  vpc_security_group_ids = [var.EC2-SG-ID]
  associate_public_ip_address = "true"

  key_name = var.Key_Name

  root_block_device {
         volume_size = var.Volume_Size
         volume_type = var.Volume_Type
         delete_on_termination = "true"
         encrypted = "true"
  }
  
 // network_interface{
//    device_index = "0"    
//    network_interface_id = aws_network_interface.ec2_network_interface.id
//  }

  tags = { 
    Name = "${var.project_name}-ec2"
  }

  user_data  = <<-EOF
  #!/bin/bash
  sudo yum install git -y
  EOF
}
  

resource "aws_eip" "ip_assos" {
  domain = "vpc"
  instance = aws_instance.ec2_instance.id
}



