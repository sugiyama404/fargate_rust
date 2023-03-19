variable "app_name" {}
#variable "apserver_sg_id" {}
variable "subnet_p1a_id" {}
#variable "webserver_sg_id" {}
variable "subnet_p1c_id" {}
variable "alb_sg_id" {}
variable "s3_bucket_id" {}

# alb
resource "aws_lb" "alb" {
  name               = "${var.app_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${var.alb_sg_id}"]
  subnets = [
    "${var.subnet_p1a_id}",
    "${var.subnet_p1c_id}"
  ]
  # アクセスログ
  access_logs {
    # バケット名を指定
    bucket  = var.s3_bucket_id
    enabled = true
  }
}
