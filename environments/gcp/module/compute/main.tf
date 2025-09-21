resource "google_project_service" "compute" {
  project = var.project
  service = "compute.googleapis.com"
}

resource "google_compute_instance" "default" {
    provider = google-beta
    name         = "basic-instance"
    zone         = "us-central1-a"
    machine_type = "e2-micro"
    project = var.project

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-11"
        }
    }

    network_interface {
        network = "default"
    }

    network_interface {
        network_attachment = var.network_attachment
    }
}
