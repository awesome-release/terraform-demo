provider "aws" {
  region  = "us-east-1"
  profile = "prod"
  alias = "us-east-1"
}

data "aws_acm_certificate" "tld" {
  provider = aws.us-east-1
  domain      = var.tld_name
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}
