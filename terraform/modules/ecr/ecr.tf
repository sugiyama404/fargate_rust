variable "web_app_name" {}
variable "api_app_name" {}

# EcrRepository for api
resource "aws_ecr_repository" "api_repository" {
  name                 = var.api_app_name
  image_tag_mutability = "IMMUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true
  }
}

# EcrRepository for web
resource "aws_ecr_repository" "web_repository" {
  name                 = var.web_app_name
  image_tag_mutability = "IMMUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true
  }
}

