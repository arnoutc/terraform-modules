terraform {
  required_version      = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source            = "hashicorp/aws"
      version           = "~> 4.0"
    }
  }
}

provider "aws" {
  region                 = "eu-west-2"
}

module "hello-world-app" {
    source               = "../../services/hello-world-app"

    server_text          = "Hello, World"
    environment          = var.environment

    postgres_config      = var.postgres_config

    instance_type       = "t2.micro"
    min_size            = 2
    max_size            = 2
    ami                 = data.aws_ami.ubuntu.id
    enable_autoscaling  = false
}

data "aws_ami" "ubuntu" {
  most_recent           = true
  owners                = ["099720109477"] # Canonical

  filter {
    name                = "name"
    values              = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

