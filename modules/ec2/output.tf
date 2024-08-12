# modules/ec2/outputs.tf
output "instance_id" {
  value = aws_instance.example.id
}
output "instance_public_ip" {
  value = aws_instance.example.public_ip
}
output "instance_private_ip" {
  value = aws_instance.example.private_ip
}
output "instance_public_dns" {
  value = aws_instance.example.public_dns
}
