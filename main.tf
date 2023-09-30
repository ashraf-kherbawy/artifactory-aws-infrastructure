terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}

module "private_ecr_module" {
  source = "./aws/private-ecr/terraform/"
}

module "s3-bucket" {
    source = "./aws/s3/terraform/"
}

module "rds-postgresql" {
    source = "./aws/rds/terraform/"
}

module "aws-loadbalancer-controller" {
  source = "./aws/aws-loadbalancer-controller/terraform"
}