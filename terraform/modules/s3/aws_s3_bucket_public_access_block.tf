resource "aws_s3_bucket_public_access_block" "alb_access_log" {
  bucket                  = aws_s3_bucket.alb_access_log.id
  block_public_acls       = true
  block_public_policy     = true # Create
  ignore_public_acls      = true
  restrict_public_buckets = false # Modify
  depends_on = [
    aws_s3_bucket_policy.alb_access_log,
  ]
}
