terraform {

  required_providers {
    aws = {
      version = ">= 5.39.0"
      source  = "hashicorp/aws"
    }
  }
  cloud {
    organization = "Tanushree-Test-Org"
    hostname     = "app.terraform.io"
    workspaces {
      project = "demo_repo"
      name    = "demo_repo_default"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_iam_role" "very-secure-role" {
  name = "very-secure-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  tags = {
    createdBy     = "terraform"
    terraformTime = "${timestamp()}"
    CanDelete     = "true"
    product       = "credit-boost"
  }
}
# This is the git root