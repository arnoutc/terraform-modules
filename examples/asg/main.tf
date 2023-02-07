provider "aws" {
  region = "eu-west-2"
}

module "asg" {
  source = "../../modules/cluster/asg-rolling-deploy"

  cluster_name = var.cluster_name
  ami = "ami-0d09654d0a20d3ae2"
  instance_type = "t2.micro"

  min_size = 1
  max_size = 1
  enable_autoscaling = false

  subnet_ids        = data.aws_subnets.default.ids
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}