variable "app_name" {}
variable "web_app_name" {}
variable "api_app_name" {}

# CloudWatchLog for Fargate api
resource "aws_cloudwatch_log_group" "app" {
  name              = "/fargate/${var.app_name}/dev/${var.api_app_name}"
  retention_in_days = 1
}

# CloudWatchLog for Fargate web
resource "aws_cloudwatch_log_group" "web" {
  name              = "/fargate/${var.app_name}/dev/${var.web_app_name}"
  retention_in_days = 1
}
