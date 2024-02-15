terraform {
  backend "s3" {
    bucket = "boafoa-terraform-bucket"
    key = "key/terraform.tfstate"
    encrypt = true
    region = "eu-west-2"
    dynamodb_table = "Terraform-Table"
  }
}