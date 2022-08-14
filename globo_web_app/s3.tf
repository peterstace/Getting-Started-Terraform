locals {
  bucket_name = "globo-web-app-${random_integer.rand.result}"
}
## aws_s3_bucket
resource "aws_s3_bucket" "b" {
  bucket        = local.bucket_name
  acl           = "private"
  force_destroy = true
  policy        = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "${data.aws_elb_service_account.root.arn}"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::${local.bucket_name}/alb-logs/*"
    },
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "delivery.logs.amazonaws.com"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::${local.bucket_name}/alb-logs/*",
      "Condition": {
        "StringEquals": {
          "s3:x-amz-acl": "bucket-owner-full-control"
        }
      }
    },
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "delivery.logs.amazonaws.com"
      },
      "Action": "s3:GetBucketAcl",
      "Resource": "arn:aws:s3:::${local.bucket_name}"
    }
  ]
}
  POLICY
  tags          = local.common_tags
}

locals {
  file_logo  = "Globo_logo_Vert.png"
  file_index = "index.html"
}

## aws_s3_bucket_object
resource "aws_s3_bucket_object" "website_content" {
  for_each = {
    website = "website/index.html"
    logo    = "website/Globo_logo_Vert.png"
  }
  bucket = aws_s3_bucket.b.bucket
  key    = each.value
  source = "./${each.value}"
  tags   = local.common_tags
}

## aws_iam_role
resource "aws_iam_role" "allow_nginx_s3" {
  name = "allow_nginx_s3"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = { Service = "ec2.amazonaws.com" }
      },
    ]
  })
  tags = local.common_tags
}

## aws_iam_role_policy
resource "aws_iam_role_policy" "allow_s3_all" {
  name = "allow_s3_all"
  role = aws_iam_role.allow_nginx_s3.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::${aws_s3_bucket.b.bucket}",
        "arn:aws:s3:::${aws_s3_bucket.b.bucket}/*"
      ]
    }
  ]
}
EOF
}

## aws_instance_profile
resource "aws_iam_instance_profile" "nginx_profile" {
  name = "nginx_profile"
  role = aws_iam_role.allow_nginx_s3.name
  tags = local.common_tags
}
