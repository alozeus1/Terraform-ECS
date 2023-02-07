resource "aws_s3_bucket" "sourcefuss-bucket" {
  bucket = "sourcefuss-nginx-logs"
}

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.sourcefuss-bucket.id
  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}

data "aws_iam_policy_document" "allow_access_from_another_account" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["ACCOUNT_ID"]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.sourcefuss-bucket.arn,
      "${aws_s3_bucket.sourcefuss-bucket.arn}/*",
    ]
  }
}
