variable "project_id" {
  description = "The ID of the project where router and nat will be created"
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