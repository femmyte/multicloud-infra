terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.36.1"
    }
  }
}
provider "google" {
  project     = "bridgetowork"
  region      = "us-central1"
  credentials = file("./femmyte-4afb814b6352.json")

}

provider "google-beta" {
  region = "us-central1"
  zone   = "us-central1-a"
  credentials = file("./femmyte-4afb814b6352.json")
}
