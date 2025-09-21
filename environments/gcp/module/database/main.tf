resource "google_compute_global_address" "private_ip_address" {
    provider      = google-beta
    name          = "private-ip"
    purpose       = "VPC_PEERING"
    address_type  = "INTERNAL"
    prefix_length = 16
    network       = var.vpc_name
    project       = var.project
}

resource "google_service_networking_connection" "private_vpc_connection" {
  provider                = google-beta
  network                 = var.vpc_name
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

resource "google_sql_database_instance" "default" {
  name                = var.db_name
  project             = var.project
  region              = var.region
  database_version    = "POSTGRES_14"
  deletion_protection = false

  settings {
    tier = var.db_machine_type
    ip_configuration {
      ipv4_enabled = false
      private_network = var.network_self_link
    #   require_ssl = true
    }
  }
  depends_on = [
    # google_project_service.sqladmin,
    google_service_networking_connection.private_vpc_connection
  ]
}

resource "random_string" "root_password" {
  length           = 16
  override_special = "%*()-_=+[]{}?"
}

resource "google_sql_user" "root" {
  name                = "root"
  project             = var.project
  instance            = google_sql_database_instance.default.name
  password            = random_string.root_password.result
}