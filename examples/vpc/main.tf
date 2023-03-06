resource "aws_vpc" "example_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true # gives an internal domain name
  enable_dns_hostnames = true # gives an internal host name
  instance_tenancy = "default"

  tags = {
    Name = "example-vpc"
  }
}

resource "aws_subnet" "example-subnet-public-1" {
    vpc_id = aws_vpc.example_vpc.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true # it makes this a public subnet
    availability_zone = "eu-west-2a"

    tags = {
      Name = "example-subnet-public-1"
    }
}

resource "aws_subnet" "example-subnet-private-1" {
  vpc_id = aws_vpc.example_vpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = false # this is a private subnet
  availability_zone = "eu-west-2b"

  tags = {
    Name = "example-subnet-private-1"
  }
}

resource "aws_subnet" "example-subnet-private-2" {
  vpc_id = aws_vpc.example_vpc.id
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = false # this is a private subnet
  availability_zone = "eu-west-2c"

  tags = {
    Name = "example-subnet-private-2"
  }
}