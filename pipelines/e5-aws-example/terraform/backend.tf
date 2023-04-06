provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "terraform.huge.head.li.2023"
    dynamodb_table = "terraform-state-lock"
    key            = "e5-aws-example"
    region         = "us-east-1"
  }

  required_version = ">= 1.5.1"
}