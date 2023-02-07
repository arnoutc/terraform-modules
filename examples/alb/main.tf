provider "aws" {
  region = "eu-west-2"
}

module "alb" {
  source="../../networking/alb"

  name = var.alb_name
}