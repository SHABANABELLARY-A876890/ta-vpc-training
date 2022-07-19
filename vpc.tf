resource "aws_vpc" "lab-vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.lab-vpc.id
  cidr_block = var.cidr_public

  tags = {
    Name = "Public"
  }
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.lab-vpc.id
  cidr_block = var.cidr_private

  tags = {
    Name = "Private"
  }
}

resource "aws_subnet" "data" {
  vpc_id     = aws_vpc.lab-vpc.id
  cidr_block = var.cidr_data

  tags = {
    Name = "Data"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.lab-vpc.id

  tags = {
    Name = "main-internet-gateway"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_iep.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_eip" "nat_iep" {
  vpc      = true
}