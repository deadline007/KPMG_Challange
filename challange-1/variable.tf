variable "project_id" {
  description = "The ID of the project where this VPC will be created"
}

variable "network_name" {
  description = "The name of the network being created"
}

variable "routing_mode" {
  type        = string
  default     = "GLOBAL"
  description = "The network routing mode (default 'GLOBAL')"
}

variable "description" {
  type        = string
  description = "An optional description of this resource. The resource must be recreated to modify this field."
  default     = ""
}

variable "auto_create_subnetworks" {
  type        = bool
  description = "When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources."
  default     = false
}

variable "delete_default_internet_gateway_routes" {
  type        = bool
  description = "If set, ensure that all routes within the network specified whose names begin with 'default-route' and with a next hop of 'default-internet-gateway' are deleted"
  default     = true
}

variable "mtu" {
  type        = number
  description = "The network MTU. Must be a value between 1460 and 1500 inclusive. If set to 0 (meaning MTU is unset), the network will default to 1460 automatically."
  default     = 1460
}


variable "subnets" {
  type        = list(map(string))
  description = "The list of subnets being created"
}


variable "ingress_rules" {
  description = "List of ingress rules. This will be ignored if variable 'rules' is non-empty"
  default     = []
  type = list(object({
    name                    = string
    description             = optional(string, null)
    priority                = optional(number, null)
    destination_ranges      = optional(list(string), [])
    source_ranges           = optional(list(string), [])
    source_tags             = optional(list(string))
    source_service_accounts = optional(list(string))
    target_tags             = optional(list(string))
    target_service_accounts = optional(list(string))

    allow = optional(list(object({
      protocol = string
      ports    = optional(list(string))
    })), [])
    deny = optional(list(object({
      protocol = string
      ports    = optional(list(string))
    })), [])
    log_config = optional(object({
      metadata = string
    }))
  }))
}




variable "name" {
  type = string
}
variable "machine_type" {
  type = string
}

variable "image" {
  type = string
}

variable "zone" {
  type        = string
  description = "Zone where the instances should be created. If not specified, instances will be spread across available zones in the region."
  default     = null
}
variable "subnetwork" {
  description = "Subnet to deploy to. Only one of network or subnetwork should be specified."
  type        = string
  default     = ""
}

variable "subnetwork_project" {
  description = "The project that subnetwork belongs to"
  type        = string
  default     = ""
}

variable "instance_group_name" {
  description = "The instance group reqiure a name"
  type = string
}



variable "router_name" {
  description = "The name of the router will be created"
  type = string
}


variable "region" {
  type = string
}

variable "network" {
  type = string
}

variable "nat_name" {
  description = "The name of the router will be created"
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

variable "private_ip_address_name" {
  type = string
}

variable "database_version" {
  type = string
}

variable "tier" {
  type = string
}

