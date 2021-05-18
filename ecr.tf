variable "aws_region" {
  default = "us-east-1"
}

variable "image_name" {
  default = "deeplearning"
}

provider "aws" {
	region = var.aws_region
}

resource "aws_ecr_repository" "dl" {
  name                 = var.image_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }  
}

data "aws_ecr_authorization_token" "token" {
}

data "aws_caller_identity" "current" {}

