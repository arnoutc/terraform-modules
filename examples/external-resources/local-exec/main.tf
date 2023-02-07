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

resource "aws_instance" "example" {
    ami = "ami-0d09654d0a20d3ae2"
    instance_type = "t2.micro"
  
    provisioner "local-exec" {
      command = "echo \"Hello, World from $(uname -smp)!\""
    }
}