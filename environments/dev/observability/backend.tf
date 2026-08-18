terraform {
  backend "s3" {
    bucket = "myamae-terraform-state-keigo-takahashi"
    key    = "dev/observability.tfstate"
    region = "ap-northeast-1"
  }
}
