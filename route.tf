#we are creating internet route for the nat gateway
resource "aws_route_table" "internet_route_table" {
  vpc_id = aws_vpc.lab-vpc.id
  #vpc_id = aws_vpc.la

  route {
    cidr_block = "0.0.0.0/0" 
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "internet_route_table"
  }
}

resource "aws_route_table" "nat_route_table" {
  vpc_id = aws_vpc.lab.id
  route {
    cidr_block = "0.0.0.0/0" 
    gateway_id = aws_nat_gateway.nat_gw.id
    
  }
  tags = {
    Name = "nat_route_table"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.internet_route_table.id
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.nat_route_table.id
}

resource "aws_route_table_association" "data" {
  subnet_id      = aws_subnet.data.id
  route_table_id = aws_route_table.nat_route_table.id
}