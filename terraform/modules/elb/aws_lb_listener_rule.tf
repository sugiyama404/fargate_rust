# LbListenerRule for api
resource "aws_lb_listener_rule" "api-ecs" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api_alb_target_group.arn
  }
  condition {
    path_pattern {
      values = ["/api/*"]
    }
  }
}
