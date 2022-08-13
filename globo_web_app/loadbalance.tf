## aws_lb
resource "aws_lb" "nginx" {
  name               = "globo-web-app"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]

  enable_deletion_protection = false

  tags = local.common_tags
}

## aws_lb_target_group

## aws_lb_listener

## aws_lb_target_group_attachment
