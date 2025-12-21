output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value = aws_instance.app.public_ip
}

output "ec2_public_dns" {
  description = "Public DNS of the EC2 instance"
  value = aws_instance.app.public_dns
}

output "elastic_ip" {
  description = "Elastic IP address attached to the EC2 instance"
  value       = aws_eip.app.public_ip
}