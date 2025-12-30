terraform {
  backend "s3" {
    bucket = "sod-terraform-states-sboiciuc-eu-west-1"
      key            = "stage/terraform.tfstate"
      region         = "eu-west-1"
      dynamodb_table = "terraform-locks"
      encrypt        = true
    }
}