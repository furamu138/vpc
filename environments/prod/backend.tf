terraform {
  backend "s3" {
    bucket = "udemy-terraform-s3-keigo-takahashi"
    key    = "prod/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

