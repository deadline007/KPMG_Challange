resource "google_compute_global_forwarding_rule" "default" {
  project               = var.project_id
  name                  = "global-rule"
  network               = var.network_name
  target                = google_compute_target_http_proxy.default.id
  port_range            = "80"
  load_balancing_scheme = "INTERNAL_SELF_MANAGED"
  ip_address            = var.ip_address
}
resource "google_compute_target_http_proxy" "default" {
  project               = var.project_id
  name                  = var.target_name
  description           = "a description"
  url_map               = google_compute_url_map.default.id
}

resource "google_compute_url_map" "default" {
  project               = var.project_id
  name                  = var.url_map_name
  description           = "a description"
  default_service       = google_compute_backend_service.default.id

  path_matcher {
    name                = "allpaths"
    default_service     = google_compute_backend_service.default.id

    path_rule {
      paths             = var.path_rule
      service           = google_compute_backend_service.default.id
    }
  }
}

resource "google_compute_backend_service" "default" {
  project               = var.project_id
  name                  = var.backend_name
  port_name             = var.backend_port_name
  protocol              = var.protocol
  timeout_sec           = var.timeout_sec
  load_balancing_scheme = "INTERNAL_SELF_MANAGED"

  backend {
    group                 = var.group
    balancing_mode        = "RATE"
    capacity_scaler       = var.capacity_scaler
    max_rate_per_instance = var.max_rate_per_instance
  }

  health_checks = [google_compute_health_check.default.id]
}

resource "google_compute_health_check" "default" {
  project               = var.project_id
  name                  = var.health_checks_name
  check_interval_sec    = var.check_interval_sec
  timeout_sec           = var.timeout_sec

  tcp_health_check {
    port = var.health_checks_port
  }
}