output "public_ip" {
  value       = aws_instance.example.public_ip
  description = "This is the public ip for the instance"
}


output "public_dns" {
  value       = aws_instance.example.public_dns
  description = "This is the public dns for the instance"
}

