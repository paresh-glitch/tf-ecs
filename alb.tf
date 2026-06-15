resource "aws_lb" "alb" {
  name               = "${var.env}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets = module.vpc.public_subnets

  tags = {
    Environment = var.env
  }
}

resource "aws_lb_target_group" "tg" {
  name        = "${var.env}-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = "${var.env}-tg"
    Environment = var.env
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}
