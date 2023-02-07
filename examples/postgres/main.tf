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

module "postgres" {
  source            ="../../data-stores/postgres"

  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password
}

