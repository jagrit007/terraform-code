terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.92.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  # access_key = ""
  # secret_key = ""

  # env vars:
  # % export AWS_ACCESS_KEY_ID="anaccesskey"
  # % export AWS_SECRET_ACCESS_KEY="asecretkey"
  # % export AWS_REGION="us-west-2"
  # % terraform plan
}
