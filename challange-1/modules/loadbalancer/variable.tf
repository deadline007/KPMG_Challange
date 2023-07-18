variable "project_id" {
    type = string
}

variable "network_name" {
  type = string
}

variable "ip_address" {
  type = string
}

variable "target_name" {
  type = string
}

variable "url_map_name" {
  type = string
}

variable "path_rule" {
  type = list(string)
}

variable "backend_name" {
  type = string
}

variable "backend_port_name" {
  type = string
}

variable "protocol" {
  type = string
}

variable "group" {
  type = string
}

variable "capacity_scaler" {
  type = string
}

variable "max_rate_per_instance" {
  type = number
}

variable "health_checks_name" {
  type = string
}

variable "check_interval_sec" {
  type = number
}

variable "timeout_sec" {
  type = number
}

variable "health_checks_port" {
  type = number
}