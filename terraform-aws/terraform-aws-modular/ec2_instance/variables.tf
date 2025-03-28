variable "ami_value" {
  #   default = ""
  description = "Value for the AMI"
  type        = string
}

variable "instance_type" {
  type        = string
  description = "The type of instance to create"
}

variable "security_group_name" {
  type        = string
  description = "The value for security group name"
}

variable "key_name" {
  type        = string
  description = "The value for key-pair name"
}

variable "key_pair_filepath" {
  type        = string
  description = "the absolute path of where the key is stored"
}

variable "allowed_ssh_cidr" {
  description = "CIDR for SSH, default: 0.0.0.0/0"
  default     = ["0.0.0.0/0"]
  type        = list(string)
}