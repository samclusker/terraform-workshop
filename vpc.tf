resource "aws_vpc" "workshopVPC" {
  cidr_block = "10.0.0.0/16"

  enable_dns_hostnames = true

  tags = {
    Name = "Workshop VPC"
  }
}

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.workshopVPC.id

  map_public_ip_on_launch = true

  cidr_block = "10.0.1.0/24"

  availability_zone = "eu-west-2b"

  tags = {
    Name = "workshop-public-subnet"
  }

  depends_on = [
    aws_vpc.workshopVPC
  ]

}

resource "aws_internet_gateway" "public" {
  vpc_id = aws_vpc.workshopVPC.id

  tags = {
    Name = "Workshop Public IG"
  }

  depends_on = [
    aws_vpc.workshopVPC
  ]
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.workshopVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.public.id
  }

  tags = {
    Name = "Workshop IG Route Table"
  }

  depends_on = [
    aws_vpc.workshopVPC,
    aws_internet_gateway.public
  ]

}

resource "aws_route_table_association" "public" {

  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id

  depends_on = [
    aws_subnet.public,
    aws_route_table.public
  ]

}