resource "aws_key_pair" "my_key_pair" {
  key_name   = "my_key_pair_01"
  public_key = file("terraform_example_key.pub")
}

resource "aws_default_vpc" "my_vpc" {}


resource "aws_security_group" "my_security_group" {
  name        = "my_security_group - Allow SSH"
  description = "Opens port for SSH"
  vpc_id      = aws_default_vpc.my_vpc.id # interpolation
  # incoming
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "This port is required for SSH"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # outgoing
  egress {
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1" # ALL
    description = "Allow all outgoing traffic from the EC2 instance"
  }
}

resource "aws_instance" "my-instance" {
  ami             = "ami-084568db4383264d4"
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.my_key_pair.key_name
  security_groups = [aws_security_group.my_security_group.name]

  tags = {
    Name = "terraform-ec2-instance"
  }
}


resource "aws_dynamodb_table" "my-dynamodb-table" {
  name         = var.dynamodb_tbl_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"
  attribute {
    name = "id"
    type = "S"
  }
}