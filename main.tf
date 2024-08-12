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

output "vault_token" {
  value     = var.vault_token
  sensitive = true
}

#@ VAULT 
# provider "vault" {
#   address = "http://127.0.0.1:8200"
#   token   = "hvs.cb86iN91XY0pHfGLhjWDOoyn"
#   skip_child_token = true
# }
# data "vault_generic_secret" "username" {
#   path = "secret/mysecret"
# }
# output "get_data_from_vault" {
#   value     = data.vault_generic_secret.username
#   sensitive = true
# }
#@ _end_vault ----------------------------------------------------------------

provider "aws" {
  region     = var.REGION
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
  # profile = "maverick"
  default_tags {
    tags = {
      Owner       = "maverick"
      Provisioner = "terraform"
      Environment = terraform.workspace
    }
  }
}

variable "AMIS" {
  type = map(any)
  default = {
    ap-southeast-1 = "asdasdas"
    ap-southeast-2 = "asasdasdasdas"
  }
  description = "AMI for EC2 instances"
}

variable "EC2_TYPES" {
  type = map(any)
  default = {
    ap-southeast-1 = "t2.micro"
    ap-southeast-2 = "t2.medium"
  }
  description = "EC2 instance types for different regions"
}

variable "REGION" {
  default     = "ap-southeast-1"
  type        = string
  description = "Region Singapore"
}
#@ validate, require input value for cloud
# variable "cloud" {
#   type = string
#   validation {
#     condition     = contains(["aws", "azure", "gcp", "vmware"], lower(var.cloud))
#     error_message = "You must use an approved cloud."
#   }
#   validation {
#     condition     = lower(var.cloud) == var.cloud
#     error_message = "The cloud name must not have capital letters."
#   }
# }

locals {
  zone1 = "${var.REGION}a"
  tags = {
    Name = "module"
  }
}

data "aws_region" "current" {}
data "aws_availability_zones" "availability_zone" {}
# data "aws_ami" "ubuntu" {
#   most_recent = true         #? newest
#   owners      = ["51655656"] #? owner's ID

#   filter { #? by AMI's name
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
# }

#?  tạo nhiều instances EC2. Mỗi instance is match corresponding AZ
# resource "aws_instance" "demo" {]
  # for_each          = var.EC2_TYPES #? mandatory map
#   availability_zone = tolist(data.aws_availability_zones.availability_zone.names)[each.value]
#   ami               = data.aws_ami.ubuntu.id #var.AMIS[var.REGION]
#   instance_type     = var.EC2_TYPES[var.REGION]
#   key_name          = "terraform"
#   # availability_zone = data.aws_availability_zones.available.names[0] 
#   subnet_id                   = "asdasd"
#   vpc_security_group_ids      = ["asdasdas"]
#   associate_public_ip_address = true

#   tags = {
#     Name    = "demo"
#     Project = "demo"
#     Region  = data.aws_region.current.name
#   }
# }
# resource "aws_instance" "my_instance" {
#   ami           = "ami-0a6b545f62129c495"
#   instance_type = "t2.micro"
# }
# output "public_ip" {
#   description = "public URL for webserver"
#   value       = { for k, v in aws_instance.demo : k => "http://${v.private_ip}:8080/index.html" }
# }

#> terraform state show module.ec2.aws_instance.example
#@ MODULE   
module "ec2" {
  source          = "./modules/ec2"
  ami             = "ami-0a6b545f62129c495"
  instance_type   = "t2.micro"
  key_name        = var.key_name
  connection_user = var.connection_user
  tags = local.tags

}
#* template module 
# module "autoscaling" {
#   source  = "terraform-aws-modules/autoscaling/aws"
#   version = "7.7.0"
#   # insert the 1 required variable here
# }
# output "instance_id" {
#   value       = module.ec2.instance_id
#   sensitive   = true
#   description = "instance id"
# }
# output "instance_public_ip" {
#   value = module.ec2.instance_public_ip
# }
# output "instance_private_ip" {
#   value = module.ec2.instance_private_ip
# }
# output "instance_public_dns" {
#   value = module.ec2.instance_public_dns
# }
#@ end MODULE   ----------------------------------------------------
 