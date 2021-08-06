terraform {
  required_version = ">= 1.0.0"

  backend "s3" {
    bucket = "terraform-workshop-sc"
    key    = "terraform-workshop.tfstate"
    region = "eu-west-2"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

}

provider "aws" {
  region = "eu-west-2"
}