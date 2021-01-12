data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "demo" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"


  tags = {
    Name = "demo"
    created = "Terraform"
    Env     = var.ENV
  }
}

# Subnets public
resource "aws_subnet" "demo-public-1" {
  vpc_id     = aws_vpc.demo.id
  cidr_block = var.public_subnet[0]
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = "true"


  tags = {
    Name = "Demo-public-1"
  }
}

resource "aws_subnet" "demo-public-2" {
  vpc_id     = aws_vpc.demo.id
  cidr_block = var.public_subnet[1]
  availability_zone = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = "true"


  tags = {
    Name = "Demo-public-1"
  }
}

# Subnets private
resource "aws_subnet" "demo-private-1" {
  vpc_id     = aws_vpc.demo.id
  cidr_block = var.private_subnet[0]
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = "false"


  tags = {
    Name = "Demo-private-1"
  }
}

resource "aws_subnet" "demo-private-2" {
  vpc_id     = aws_vpc.demo.id
  cidr_block = var.private_subnet[1]
  availability_zone = data.aws_availability_zones.available.names[1]
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
