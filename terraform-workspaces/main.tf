provider "aws" {
  region = "us-east-1"
}

variable "ami" {
  description = "The AMI value for the instance"
}

variable "instance_type" {
  description = "The type of the instance to create"
  type        = map(string)
  default = {
    "dev"     = "t2.micro",
    "staging" = "t2.medium",
    "prod"    = "t2.xlarge"
  }
}


module "ec2_instance" {
  source        = "./modules/ec2"
  ami           = var.ami
  instance_type = lookup(var.instance_type, terraform.workspace, "t2.micro")
}