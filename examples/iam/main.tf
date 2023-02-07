terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}

resource "aws_iam_user" "stageadmin" {
  name = "stageadmin"
}

resource "aws_iam_access_key" "iam_access_key" {
  user = aws_iam_user.stageadmin.name
}