provider "aws" {
  region = var.region
  profile = var.profile
}

terraform {
  required_version = ">= 0.14.7"

  required_providers {
    aws = ">= 3.30.0"
  }
}
