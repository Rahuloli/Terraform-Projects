terraform {

  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.26.0"
    }
  }
  
  required_version = ">= 0.12"
}

provider "aws" {
    region = var.aws_region
}
