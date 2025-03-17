########データソースの宣言########

data "aws_availability_zones" "available" {
  state = "available"
}

######## vpc ########
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpccidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.project_name}-vpc"
  }
}

######## internet gateway ########
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.project_name}-igw"
  }
}

######## subnet ########
resource "aws_subnet" "public_subnet_a" {
  availability_zone       = element(data.aws_availability_zones.available.names, 0)
  cidr_block              = var.public_subnet_acidr
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_name}-PubSubA"
  }
}

resource "aws_subnet" "public_subnet_c" {
  availability_zone       = element(data.aws_availability_zones.available.names, 1)
  cidr_block              = var.public_subnet_ccidr
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_name}-PubSubC"
  }
}

resource "aws_subnet" "private_subnet_a" {
  availability_zone = element(data.aws_availability_zones.available.names, 0)
  cidr_block        = var.private_subnet_acidr
  vpc_id            = aws_vpc.vpc.id
  tags = {
    Name = "${var.project_name}-PriSubA"
  }
}

resource "aws_subnet" "private_subnet_c" {
  availability_zone = element(data.aws_availability_zones.available.names, 1)
  cidr_block        = var.private_subnet_ccidr
  vpc_id            = aws_vpc.vpc.id
  tags = {
    Name = "${var.project_name}-PriSubC"
  }
}

######## route table ########
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.project_name}-PublicRouteTable"
  }
}

resource "aws_route_table" "private_route_table1" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.project_name}-PrivateRouteTable1"
  }
}

resource "aws_route_table" "private_route_table2" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.project_name}-PrivateRouteTable2"
  }
}

######## public route ########
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}

######## routetable with subnet ########
resource "aws_route_table_association" "public_subnet_route_a_table_association" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet_route_c_table_association" {
  subnet_id      = aws_subnet.public_subnet_c.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_subnet_route_a_table_association" {
  subnet_id      = aws_subnet.private_subnet_a.id
  route_table_id = aws_route_table.private_route_table1.id
}

resource "aws_route_table_association" "private_subnet_route_c_table_association" {
  subnet_id      = aws_subnet.private_subnet_c.id
  route_table_id = aws_route_table.private_route_table2.id
}



