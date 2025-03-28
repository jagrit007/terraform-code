resource "aws_key_pair" "project-key-pair" {
  key_name   = local.key_name
  public_key = file(var.key_path)
}

resource "aws_vpc" "project-vpc" {
  cidr_block = var.cidr_block
}


resource "aws_subnet" "project-subnet" {
  vpc_id                  = aws_vpc.project-vpc.id
  cidr_block              = aws_vpc.project-vpc.cidr_block
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = var.map_public_ip_on_launch
}

resource "aws_internet_gateway" "project-internet-gateway" {
  vpc_id = aws_vpc.project-vpc.id

}

resource "aws_route_table" "project-route-table" {
  vpc_id = aws_vpc.project-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project-internet-gateway.id
  }
}

resource "aws_route_table_association" "project-rta" {
  subnet_id      = aws_subnet.project-subnet.id
  route_table_id = aws_route_table.project-route-table.id
}

resource "aws_security_group" "project-security-group" {
  vpc_id = aws_vpc.project-vpc.id
  name   = local.security_group_name

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-security-group"
  }
}

resource "aws_instance" "project_instance" {
  ami                    = var.ami_value
  availability_zone      = var.availability_zone
  vpc_security_group_ids = [aws_security_group.project-security-group.id]
  key_name               = aws_key_pair.project-key-pair.key_name
  subnet_id              = aws_subnet.project-subnet.id
  instance_type          = var.instance_type

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "./app/app.py"
    destination = "/home/ubuntu/app.py"

  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Connected to the remote machine!'",
      "sudo apt update -y && sudo apt install python3-pip python3.12-venv -y",
      "cd ~",
      "python3 -m venv venv && source venv/bin/activate",
      "pip3 install flask",
      "python3 app.py &"

    ]
  }

  tags = {
    Name        = "${var.project_name}-instance"
    Environment = var.runtime_env
  }
}