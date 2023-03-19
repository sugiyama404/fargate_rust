resource "aws_s3_bucket" "alb_access_log" {
  bucket        = "access-log-${random_string.s3_unique_key.result}"
  force_destroy = true

  versioning {
    enabled = false
  }
}

resource "random_string" "s3_unique_key" {
  length  = 6
  upper   = false
  lower   = true
  number  = true
  special = false
}
