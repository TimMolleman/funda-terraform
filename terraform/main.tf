terraform {
  # Terraform version
  required_version = ">=0.12.34"

  # Providers
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.72.0"
    }
  }

  backend "s3" {
    bucket = "fundastate"
    key    = "funda.tfstate"
    region = "eu-west-2"
  }
}

provider "aws" {
  region = "eu-west-2"
}