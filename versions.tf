terraform {
  required_version = "~> 1.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "twdps"
    workspaces {
      prefix = "lab-platform-aws-cloudwatch-base-"
    }
  }
}

provider "aws" {
  region = var.aws_default_region
  assume_role {
    role_arn     = "arn:aws:iam::${var.aws_account_id}:role/${var.aws_assume_role}"
    session_name = "lab-platform-aws-cloudwatch-base"
  }

  default_tags {
    tags = {
      Pipeline = "lab-platform-aws-cloudwatch-base"
    }
  }
}