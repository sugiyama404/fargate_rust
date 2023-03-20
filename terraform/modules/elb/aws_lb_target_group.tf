variable "web_app_name" {}
variable "api_app_name" {}
variable "main_vpc_id" {}
variable "web_ports" {}
variable "api_ports" {}

# LbTargetGroup for api
resource "aws_lb_target_group" "api_alb_target_group" {
  name        = "${var.api_app_name}-tg"
  port        = var.api_ports[0].internal
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.main_vpc_id

  health_check {
    interval            = 300
    path                = "/"
    port                = var.api_ports[0].internal
    protocol            = "HTTP"
    timeout             = 120
    unhealthy_threshold = 10
    matcher             = "200-299"
  }
}

# LbTargetGroup for web
resource "aws_lb_target_group" "web_alb_target_group" {
  name        = "${var.web_app_name}-tg"
  port        = var.web_ports[0].internal
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.main_vpc_id

  health_check {
    interval            = 300
    path                = "/index.html"
    port                = var.web_ports[0].internal
    protocol            = "HTTP"
    timeout             = 120
    unhealthy_threshold = 10
    matcher             = "200-299"
  }
}
