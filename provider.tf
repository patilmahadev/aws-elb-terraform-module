provider "aws" {
  region = var.region
  profile = var.profile
}

terraform {
  required_version = ">= 0.14.7"

  required_providers {
    aws = ">= 3.30.0"
  }

  backend "s3" {
    region = "us-east-1"
    bucket = "830batch"
    key = "terraform/terraform.tfstate"
    dynamodb_table = "terraform-lock"
    profile = "remotex"
    encrypt = true
  }
}
