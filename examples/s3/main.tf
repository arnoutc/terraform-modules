resource "aws_iam_user" "new_user" {
  name = var.iam_username
}

resource "aws_iam_user_login_profile" "login" {
  user = aws_iam_user.new_user.name
}

resource "aws_s3_bucket" "bucket" {
  bucket_prefix = var.bucket_prefix
  object_lock_enabled = true

  tags = {
    "Name" = "My bucket"
    "Environment" = "Dev"
  }
}

resource "aws_s3_bucket_versioning" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# resource "aws_s3_object" "object" {
#   bucket = aws_s3_bucket.bucket.id
#   for_each = fileset("uploads/", "*")
#   key = each.value
#   source = "uploads/${each.value}"
#   etag = filemd5("uploads/${each.value}")
#   depends_on = [
#     aws_s3_bucket.bucket
#   ]
# }

# Setting s3:BypassGovernanceRetention in an inline policy on a user should enable the user to delete the object
# I was not able to do it though, permission was not put into effect.
resource "aws_s3_bucket_object_lock_configuration" "bucket" {
  bucket = aws_s3_bucket.bucket.bucket
  rule {
    default_retention {
      mode = "GOVERNANCE"
      days = 1
    }
  } 
}

resource "aws_s3_bucket_acl" "bucket" {
  bucket = aws_s3_bucket.bucket.id
  
  acl = "private"
}

resource "aws_s3_bucket_public_access_block" "app" {
  bucket = aws_s3_bucket.bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_iam_policy" "policy" {
  name = "${aws_s3_bucket.bucket.id}-policy"
  description = "My test policy"

  policy = data.aws_iam_policy_document.example.json
}

data "aws_iam_policy_document" "example" {
  statement {
    actions   = ["s3:ListAllMyBuckets"]
    resources = ["arn:aws:s3:::*"]
    effect = "Allow"
  }
  statement {
    actions   =["s3:*"]
    resources = [aws_s3_bucket.bucket.arn]
    effect = "Allow"
  }
}

resource "aws_iam_user_policy_attachment" "attachment" {
  user       = aws_iam_user.new_user.name
  policy_arn = aws_iam_policy.policy.arn
}