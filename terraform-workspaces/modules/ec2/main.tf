provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ec2_instance" {
  instance_type = var.instance_type
  ami           = var.ami
}

