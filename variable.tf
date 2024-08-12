variable "key_name" {
  description = "private key for ec2 instance"
  default     = "terraform.pub"
  type        = string
}

variable "connection_user" {
  description = "user for connection"
  type        = string
  default     = "ec2-user"
}