resource "aws_internet_gateway" "example-igw" {
  vpc_id = aws_vpc.example_vpc.id

  tags = {
    Name = "example-igw"
  }
}

resource "aws_route_table" "example-public-crt" {
  vpc_id = aws_vpc.example_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example-igw.id
  }

  tags = {
    Name = "example-public-crt"
  }
}

resource "aws_route_table_association" "example-crta-public-subnet-1" {
    subnet_id = aws_subnet.example-subnet-public-1.id
    route_table_id = aws_route_table.example-public-crt.id
}