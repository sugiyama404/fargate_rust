data "aws_caller_identity" "self" {}

resource "aws_s3_bucket_policy" "alb_access_log" {
  bucket = aws_s3_bucket.alb_access_log.id
  policy = data.aws_iam_policy_document.alb_access_log.json
}

data "aws_iam_policy_document" "alb_access_log" {
  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.alb_access_log.arn}/*"]
    principals {
      type        = "*"
      identifiers = ["${data.aws_caller_identity.self.account_id}"]
    }
  }
}
