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