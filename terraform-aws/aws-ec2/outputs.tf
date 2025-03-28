output "aws_ec2_ip" {
  value       = aws_instance.my-instance.public_ip
  description = "Public IP of the instance"
}