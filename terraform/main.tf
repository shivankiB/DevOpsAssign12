locals {
  key_name = var.existing_key_name
}

resource "aws_security_group" "devops_sg" {
  name        = "devops-sg"
  description = "Allow SSH, HTTP, Django, and Swarm ports"

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

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 2377
    to_port     = 2377
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 7946
    to_port     = 7946
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 4789
    to_port     = 4789
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "devops-sg" }
}

# Swarm Manager
resource "aws_instance" "manager" {
  ami                    = var.ubuntu_ami
  instance_type          = var.instance_type
  key_name               = local.key_name
  vpc_security_group_ids = [aws_security_group.devops_sg.id]
  tags = { Name = "swarm-manager" }
}

resource "aws_eip" "manager_eip" {
  instance = aws_instance.manager.id
}

# Worker A
resource "aws_instance" "worker_a" {
  ami                    = var.ubuntu_ami
  instance_type          = var.instance_type
  key_name               = local.key_name
  vpc_security_group_ids = [aws_security_group.devops_sg.id]
  tags = { Name = "swarm-worker-a" }
}

resource "aws_eip" "worker_a_eip" {
  instance = aws_instance.worker_a.id
}

# Worker B
resource "aws_instance" "worker_b" {
  ami                    = var.ubuntu_ami
  instance_type          = var.instance_type
  key_name               = local.key_name
  vpc_security_group_ids = [aws_security_group.devops_sg.id]
  tags = { Name = "swarm-worker-b" }
}

resource "aws_eip" "worker_b_eip" {
  instance = aws_instance.worker_b.id
}
