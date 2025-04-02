variable "vpc_cidr" {
  description = "cidr block value for the vpc"
}

variable "cluster_name" {
  description = "The name for the k8s cluster"
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "availability_zones" {
  type = list(string)
}

variable "public_subnet_cidrs" {
  type = list(string)
}
