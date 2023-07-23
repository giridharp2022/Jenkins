data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"    
    values = ["giridhar*"]
  }
}

resource "aws_security_group" "alb-sg" {
  name        = "alb-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = data.aws_vpc.selected.id

  ingress {
    description      = "TLS from VPC"
    from_port        = var.port1
    to_port          = var.port1
    protocol         = "tcp"
    cidr_blocks      = var.cidr_block_1
  }
  ingress {
    description      = "TLS from VPC"
    from_port        = var.port2
    to_port          = var.port2
    protocol         = "tcp"
    cidr_blocks      = var.cidr_block_1
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = var.lbsgtag
  }
}

resource "aws_security_group" "jenkins-sg" {
  name        = "jenkins-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = data.aws_vpc.selected.id
  depends_on = [aws_security_group.alb-sg]
  ingress {
    description      = "TLS from VPC"
    from_port        = var.port3
    to_port          = var.port3
    protocol         = "tcp"
    security_groups  = [aws_security_group.alb-sg.id]
  }
  
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = var.jenkinsgtag
  }
}
