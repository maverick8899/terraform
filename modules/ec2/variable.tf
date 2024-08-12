variable "ami" {
  description = "AMI ID to use"
  type        = string
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
}

variable "tags" {
  description = "tag of EC2 instance"
  type        = map(any)
}
variable "connection_user" {
  description = "connection_user of EC2 instance"
  type        = string
}

variable "key_name" {
  description = "Name of the Private Key to be used for the EC2 Instance"
  type        = string
} 