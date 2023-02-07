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

resource "aws_security_group" "instance" {
    ingress = [ {
      cidr_blocks = [ "0.0.0.0/0" ]
      description = "remote-exec"
      from_port = 22
      protocol = "tcp"
      ipv6_cidr_blocks = [  ]
      prefix_list_ids = [  ]
      security_groups = [  ]
      self = false
      to_port = 22
    } ]
}



# To make this example easy to try out, we generate a private key in Terraform.
# In real-world usage, you should manage SSH keys outside of Terraform.
resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "generated_key" {
  public_key = tls_private_key.example.public_key_openssh
}

resource "aws_instance" "example" {
    ami = "ami-0d09654d0a20d3ae2"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.instance.id]
    key_name = aws_key_pair.generated_key.key_name
  
    provisioner "remote-exec" {
      inline = ["echo \"Hello, World from $(uname -smp)!\""]
    }

    connection {
      type = "ssh"
      host = self.public_ip
      user = "ubuntu"
      private_key = tls_private_key.example.private_key_pem
    }
}