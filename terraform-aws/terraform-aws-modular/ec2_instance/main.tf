terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "tf-class-state-bucket-01"
    key            = "terraform/state.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "tf-class-tf-lock"
  }
}

locals {
  project_name = "tf-class"
}


resource "aws_key_pair" "example-key_pair" {
  key_name   = var.key_name
  public_key = file(var.key_pair_filepath)
}

resource "aws_default_vpc" "example-vpc" {

}

resource "aws_security_group" "example-sg" {
  name        = var.security_group_name
  description = "This security groups allows SSH connections"
  vpc_id      = aws_default_vpc.example-vpc.id
  ingress {
    to_port     = 22
    from_port   = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidr
  }
  egress {
    to_port     = 0
    from_port   = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.project_name}-sg"
  }

}

resource "aws_instance" "example" {
  ami             = var.ami_value
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [aws_security_group.example-sg.name]

  tags = {
    Name = "${local.project_name}-instance"
  }

}