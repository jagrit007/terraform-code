terraform {
  backend "s3" {
    bucket         = "tf-class-state-bucket-01"
    key            = "tf-0001/state.tfstate"
    dynamodb_table = "tf-class-tf-lock"
    region         = "us-east-1"
    encrypt        = true
  }
}