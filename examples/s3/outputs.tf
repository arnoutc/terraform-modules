output "s3_bucket_name" {
  value = aws_s3_bucket.bucket.id
}

output "rendered_policy" {
  value = data.aws_iam_policy_document.example.json
}

output "iam_user_arn" {
    value = aws_iam_user.new_user.arn
}

output "iam_user_id" {
    value = aws_iam_user.new_user.id
}

output "iam_user_password" {
    value = aws_iam_user_login_profile.login.password
}