terraform {
  backend "gcs" {
    bucket  = "tfstate-bridgetowork"
    prefix  = "gcp/prod"
  }
}
