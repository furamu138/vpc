terraform {
  backend "s3" {
    bucket = "myamae-terraform-state-keigo-takahashi"
    key    = "dev/terraform.tfstate"
    region = "ap-northeast-1"
  }
}
