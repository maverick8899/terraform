

terraform {
  required_version = ">=1.9.3"

  cloud {
    organization = "maverick0809"
    hostname     = "app.terraform.io" # Optional; defaults to app.terraform.io
    workspaces {
      name = "learn_terraform"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.61.0"
    }
  }

  #@ storing state file on aws s3
  # backend "s3" {
  #   bucket  = "terraform-state-maverick"
  #   key     = "terraform/backend"
  #   region  = "ap-southeast-1"
  #   profile = "maverick"
  # }
}