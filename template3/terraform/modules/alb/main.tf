######## alb ########
resource "aws_lb" "alb" {
  name               = "${var.project_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.ALB-SG-ID]
  subnets            = [var.Pub-SubA-ID, var.Pub-SubC-ID]
  ip_address_type    = "ipv4"
  tags = {
    Name = "${var.project_name}-alb"
  }
}

######## ターゲットグループ ########
resource "aws_lb_target_group" "alb_target" {
  name               = "${var.project_name}-alb-tg"
  vpc_id             = var.VPCID
  port               = "80"
  protocol           = "HTTP"
  ip_address_type    = "ipv4"
  protocol_version   = "HTTP1"
  target_type        = "instance"
  health_check {
    enabled             = true
    protocol            = "HTTP"
    unhealthy_threshold = 2  # アンヘルシーと判定するためのしきい値
    timeout             = 10 # タイムアウト時間
    interval            = 60 # ヘルスチェックの間隔
    matcher             = "200"
  }
  tags = {
    Name = "${var.project_name}-alb-tg"
  }
}

######## ターゲットグループのアタッチメント ########
resource "aws_lb_target_group_attachment" "public_ec2" {
  target_group_arn   = aws_lb_target_group.alb_target.arn
  target_id          = var.EC2ID
  port               = 80
}

######## リスナー ########
resource "aws_lb_listener" "listener" {
  load_balancer_arn  = aws_lb.alb.arn
  port               = "80"
  protocol           = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target.arn
  }
}


