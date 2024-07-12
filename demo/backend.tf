# terraform {
#   backend "s3" {
#     bucket         = "my-terraform-state-bucket-1234"
#     key            = "terraform.tfstate"
#     dynamodb_table = "terraform-s3-state-lock"
#     region         = "us-east-1"
#   }
# }