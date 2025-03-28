resource "aws_s3_bucket" "my-bucket" {
  bucket = "my-bucket-jagrit-01"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
