provider "aws" {
  region = "ap-southeast-2"

  #   default_tags {
  #     tags = {
  #       "Automation"  = "Terraform"
  #       "Project"     = "Jenkins"
  #       "Environment" = "dev"
  #     }
  #   }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}