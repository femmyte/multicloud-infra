resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }
}

resource "aws_subnet" "subnet_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.0.0/20"
  availability_zone       = var.azs[0]
  map_public_ip_on_launch = true
}

resource "aws_subnet" "subnet_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.16.0/20"
  availability_zone       = var.azs[1]
  map_public_ip_on_launch = true
}

resource "aws_route_table_association" "public_assoc" {
  for_each = {
    subnet1 = aws_subnet.subnet_1.id
    subnet2 = aws_subnet.subnet_2.id
  }
  subnet_id      = each.value
  route_table_id = aws_route_table.main.id
}

# RDS

resource "aws_db_subnet_group" "mydb_subnet_group" {
  name = "${var.RESOURCE_PREFIX}-subnet-group"
  subnet_ids = [
    aws_subnet.subnet_1.id,
    aws_subnet.subnet_2.id
  ]
}



# Security Group for Aurora\ n
resource "aws_security_group" "db_cluster_sg" {
  vpc_id = aws_vpc.main.id
  name   = "${var.RESOURCE_PREFIX}-cluster-security-group"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.RESOURCE_PREFIX}-cluster-security-group"
  }
}


resource "aws_security_group" "instance" {
  name   = "${var.RESOURCE_PREFIX}-instance-sg"
  vpc_id = aws_vpc.main.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
