resource "aws_lb" "medusa_alb" {
  name               = "medusa-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.medusa_sg.id]
  subnets           = var.subnet_ids
}

resource "aws_lb_target_group" "medusa_tg" {
  name     = "medusa-tg"
  port     = 9000
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.medusa_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.medusa_tg.arn
  }
}
