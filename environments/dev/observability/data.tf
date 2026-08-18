data "terraform_remote_state" "application" {
  backend = "s3"

  config = {
    bucket = var.application_state_bucket
    key    = var.application_state_key
    region = var.aws_region
  }
}
