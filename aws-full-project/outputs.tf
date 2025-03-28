output "public_ip" {
  value       = aws_instance.project_instance.public_ip
  description = "The public ip of the instance"
}

output "public_dns" {
  value       = aws_instance.project_instance.public_dns
  description = "The public dns of the instance"
}