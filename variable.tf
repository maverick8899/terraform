variable "AWS_ACCESS_KEY_ID" {
  description = "AWS access key ID"
  type        = string
  sensitive   = true
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "AWS secret access key"
  type        = string
  sensitive   = true
}

variable "vault_token" {
  description = "The vault_token for authentication"
  type        = string
  sensitive   = true
}
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