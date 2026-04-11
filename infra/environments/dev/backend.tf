terraform {
  backend "s3" {
    bucket         = "eric-foodfast-terraform-state"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "foodfast-terraform-locks"
    encrypt        = true
  }
}