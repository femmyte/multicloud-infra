
resource "google_project_service" "servicenetworking" {
  project = var.project
  service = "servicenetworking.googleapis.com"
}

resource "google_compute_network" "vpc_network" {
  project                 = var.project
  name                    = "vpc-network"
  auto_create_subnetworks = false
  routing_mode = "GLOBAL"
  mtu = 1460
}

resource "google_compute_subnetwork" "public_subnet" {
  name          = "public-subnet"
    project                 = var.project
  ip_cidr_range = "10.2.0.0/24"
  region        = "us-central1"
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_subnetwork" "private_subnet" {
  name          = "private-subnet"
  project                 = var.project
  ip_cidr_range = "10.2.2.0/24"
  region        = "us-central1"
  network       = google_compute_network.vpc_network.id
  private_ip_google_access = true # allow private connection
}

resource "google_compute_network_attachment" "network_attachment" {
    provider = google-beta
    project = var.project
    name   = "basic-network-attachment"
    region = "us-central1"
    description = "my basic network attachment"

    subnetworks = [google_compute_subnetwork.private_subnet.id]
    connection_preference = "ACCEPT_AUTOMATIC"
}