terraform {
  backend "s3" {
    bucket  = "bridgetowork-state-file"
    key    = "bridgetowork/terraform.tfstate"
    region = "us-east-1"
    profile = "m4ace"
  }
}