resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "todo-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "todo-igw"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.pub_subnet_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "todo-public-subnet"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "todo-public-rt"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "ec2_sg" {
  name        = "todo-ec2-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_cidr]   // my personal public IP
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {      // allow this instance to send outbound traffic to any IP address on ANY port using ANY protocol
    from_port   = 0
    to_port     = 0         // when protocol = -1, ports don't matter (because the rule applies to all protocols)
    protocol    = "-1"    // all protocols
    cidr_blocks = ["0.0.0.0/0"]  
  }

  tags = {
    Name = "todo-ec2-sg"
  }
}

resource "aws_key_pair" "main" {
  key_name   = "sod-rsakeypair-sboiciuc"
  public_key = file(pathexpand("~/.ssh/sod-rsakeypair-sboiciuc.pub"))
}

resource "aws_instance" "app" {
  ami           = "ami-049442a6cf8319180" 
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public.id
  key_name      = aws_key_pair.main.key_name

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "todo-app-ec2"
  }
}

resource "aws_eip" "app" {
  instance = aws_instance.app.id
}