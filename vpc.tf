resource "aws_vpc" "demo" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"


  tags = {
    Name = "demo"
    created = "Terraform"
  }
}

# Subnets public
resource "aws_subnet" "demo-public-1" {
  vpc_id     = aws_vpc.demo.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = "true"


  tags = {
    Name = "Demo-public-1"
  }
}

resource "aws_subnet" "demo-public-2" {
  vpc_id     = aws_vpc.demo.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = "true"


  tags = {
    Name = "Demo-public-1"
  }
}

# Subnets private
resource "aws_subnet" "demo-private-1" {
  vpc_id     = aws_vpc.demo.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = "false"


  tags = {
    Name = "Demo-private-1"
  }
}

resource "aws_subnet" "demo-private-2" {
  vpc_id     = aws_vpc.demo.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = "false"


  tags = {
    Name = "Demo-private-1"
  }
}

# Internet GW
resource "aws_internet_gateway" "demo-gw" {
  vpc_id = aws_vpc.demo.id

  tags = {
    Name = "demo"
  }
}

# route tables
resource "aws_route_table" "demo-public" {
  vpc_id = aws_vpc.demo.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo-gw.id
  }

  tags = {
    Name = "demo-public-1"
  }
}

# route associations public
resource "aws_route_table_association" "demo-public-1-a" {
  subnet_id      = aws_subnet.demo-public-1.id
  route_table_id = aws_route_table.demo-public.id
}

resource "aws_route_table_association" "demo-public-2-a" {
  subnet_id      = aws_subnet.demo-public-2.id
  route_table_id = aws_route_table.demo-public.id
}
