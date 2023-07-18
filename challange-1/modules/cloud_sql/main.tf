resource "google_compute_global_address" "private_ip_address" {
  project       = var.project_id
  name          = var.private_ip_address_name
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.network_name
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = var.network_name
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_sql_database_instance" "instance" {
  project = var.project_id
  name   = "private-instance-${random_id.db_name_suffix.hex}"
  region = var.region
  database_version  = var.database_version

  depends_on = [google_service_networking_connection.private_vpc_connection]

  settings {
    tier = var.tier
    ip_configuration {
      ipv4_enabled    = false
      private_network = var.private_network_id
    }
  }
}