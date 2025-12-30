resource "aws_security_group" "ec2_sg" {
  name        = "${var.name_prefix}-ec2-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_cidr]
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

  tags = merge(
    var.common_tags,
    {
    Name = "${var.name_prefix}-ec2-sg"
  })
}

resource "aws_key_pair" "main" {
  key_name   = var.key_pair_name
  public_key = file(pathexpand(var.public_key_path))
}

resource "aws_instance" "app" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = aws_key_pair.main.key_name

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

    tags = merge(
    var.common_tags,
    {
    Name = "${var.name_prefix}-app-ec2"
  })
}

resource "aws_eip" "app" {
  instance = aws_instance.app.id

    tags = merge(
    var.common_tags,
    {
    Name = "${var.name_prefix}-eip"
  })
}
