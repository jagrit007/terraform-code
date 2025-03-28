variable "project_name" {
  default     = "project-1"
  description = "The title of the Project in slug manner"
}

variable "cidr_block" {
  default     = "10.7.0.0/16"
  description = "The CIDR block for the VPC"
}

variable "key_path" {
  description = "The path for the key-pair file"
}

variable "availability_zone" {
  default     = "us-east-1a"
  description = "Create resources in which availability zone"
}

variable "map_public_ip_on_launch" {
  default     = true
  type        = bool
  description = "Set to true if public ip is required"
}

variable "ami_value" {
  default     = "ami-084568db4383264d4"
  type        = string
  description = "The AMI descriptor of the image to run in EC2 instance"
}

variable "runtime_env" {
  default     = "dev"
  description = "The type of env: dev/prod/staging"
  type        = string
}

variable "instance_type" {
  default     = "t2.micro"
  description = "The type of instance to create"
  type        = string
}

variable "private_key_path" {
  #   default     = "~/.ssh/id_rsa"
  description = "The complete path of the private key"
  type        = string
}
