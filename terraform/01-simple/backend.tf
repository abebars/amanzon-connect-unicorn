terraform {
  backend "s3" {
    bucket       = "ab-amazon-connect-terraform-tf-state"
    key          = "simple.tfstate"
    region       = "us-east-1"
  }
}