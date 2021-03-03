resource "aws_vpc" "myvpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.prefix}-vpc"
    Org = "remoteX"
  }
}

resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "${var.prefix}-igw"
    Org = "remoteX"
  }
}

resource "aws_subnet" "mypubsub" {
  cidr_block = var.public_subnet_cidr_block
  vpc_id = aws_vpc.myvpc.id
  availability_zone = "${var.region}a"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.prefix}-pubsub"
    Org = "remoteX"
  }
}

resource "aws_subnet" "myprisub" {
  cidr_block = var.private_subnet_cidr_block
  vpc_id = aws_vpc.myvpc.id
  availability_zone = "${var.region}b"
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.prefix}-prisub"
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
    Name = "${var.prefix}-pubrt"
    Org = "remoteX"
  }
}

resource "aws_route_table" "myprirt" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "${var.prefix}-prirt"
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