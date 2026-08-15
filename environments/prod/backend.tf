terraform {
  backend "s3" {
    bucket = "myamae-terraform-state-keigo-takahashi"
    key    = "prod/terraform.tfstate"
    region = "ap-northeast-1"
  }
}
