variable "region" {
  type = string
  description = "The AWS region name to create/manage the resource in"
  default = "eu-west-2"
}

variable "bucket_prefix" {
  type = string
  description = "The prefix to use for the s3 bucket name"
  default = "pacator-bucket"
}

variable "upload_source" {
    type = string
    description = "The source file to upload"
    default = "uploads/parameters.json"
}

variable "iam_username" {
  type = string
  description = "The IAM username to use"
  default = "new_s3_user"
}