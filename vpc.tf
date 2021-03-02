resource "aws_vpc" "myvpc" {
  cidr_block = "10.10.0.0/16"
  tags = {
    Name = "myvpc"
    Org = "remoteX"
  }
}

resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "myigw"
    Org = "remoteX"
  }
}

resource "aws_subnet" "mypubsub" {
  cidr_block = "10.10.1.0/24"
  vpc_id = aws_vpc.myvpc.id
  availability_zone = "${var.region}a"
  map_public_ip_on_launch = true
  tags = {
    Name = "mypubsub"
    Org = "remoteX"
  }
}

resource "aws_subnet" "myprisub" {
  cidr_block = "10.10.2.0/24"
  vpc_id = aws_vpc.myvpc.id
  availability_zone = "${var.region}b"
  map_public_ip_on_launch = false
  tags = {
    Name = "myprisub"
    Org = "remoteX"
  }
}

resource "aws_route_table" "mypubrt" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id
  }
  tags = {
    Name = "mypubrt"
    Org = "remoteX"
  }
}

resource "aws_route_table" "myprirt" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "myprirt"
    Org = "remoteX"
  }
}

resource "aws_route_table_association" "mypubrtasso" {
  route_table_id = aws_route_table.mypubrt.id
  subnet_id = aws_subnet.mypubsub.id
}

resource "aws_route_table_association" "myprirtasso" {
  route_table_id = aws_route_table.myprirt.id
  subnet_id = aws_subnet.myprisub.id
}