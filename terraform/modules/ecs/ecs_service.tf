variable "apserver_sg_id" {}
variable "subnet_p1a_id" {}
variable "webserver_sg_id" {}
variable "subnet_p1c_id" {}
variable "web_app_name" {}
variable "api_app_name" {}
#variable "api_alb_target_group_arn" {}
#variable "web_alb_target_group_arn" {}
#variable "lb_listener_rule_api" {}
#variable "lb_listener_rule_web" {}

# EcsService for Fargate api
resource "aws_ecs_service" "api-service" {
  name            = "${var.api_app_name}-service"
  cluster         = aws_ecs_cluster.cluster.id
  depends_on      = [aws_lb_listener_rule.api-ecs]
  task_definition = aws_ecs_task_definition.api-definition.arn
  desired_count   = 1
  # ecs exec
  enable_execute_command = true

  network_configuration {
    subnets          = ["${var.subnet_p1a_id}"]
    security_groups  = ["${var.apserver_sg_id}"]
    assign_public_ip = true
    #assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.api_alb_target_group_arn
    container_name   = var.api_app_name
    container_port   = 8080
  }

}

# EcsService for Fargate web
resource "aws_ecs_service" "web-service" {
  name            = "${var.web_app_name}-service"
  cluster         = aws_ecs_cluster.cluster.id
  depends_on      = [aws_lb_listener_rule.web-ecs, aws_lb_listener_rule.api-ecs]
  task_definition = aws_ecs_task_definition.web-definition.arn
  desired_count   = 1

  load_balancer {
    target_group_arn = var.web_alb_target_group_arn
    container_name   = var.web_app_name
    container_port   = 3000
  }

  network_configuration {
    subnets          = ["${var.subnet_p1c_id}"]
    security_groups  = ["${var.webserver_sg_id}"]
    assign_public_ip = true
    #assign_public_ip = false
  }

}
