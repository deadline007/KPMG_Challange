resource "google_service_account" "default" {
  account_id   = "service_account_id"
  display_name = "Service Account"
}

resource "google_compute_instance" "default" {
  project      = var.project_id
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = var.network
    subnetwork   = var.subnetwork
    subnetwork_project = var.subnetwork_project

  }

service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }

}



resource "google_compute_instance_group" "instance_group" {
  name     = var.instance_group_name
  project  = var.project_id
  zone     = var.zone
  instances = ["${google_compute_instance.default.self_link}"]

}