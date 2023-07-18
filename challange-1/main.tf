/******************************************
	VPC configuration
 *****************************************/
module "vpc" {
source                                   = "./modules/vpc"
  network_name                           = var.network_name
  auto_create_subnetworks                = var.auto_create_subnetworks
  routing_mode                           = var.routing_mode
  project_id                             = var.project_id
  description                            = var.description
  delete_default_internet_gateway_routes = var.delete_default_internet_gateway_routes
  mtu                                    = var.mtu
}

/******************************************
	Subnet configuration
 *****************************************/
module "subnets" {
    source       = "./modules/subnets"
    project_id   = var.project_id
    network_name = var.network_name
    subnets      = var.subnets
    depends_on   = [ module.vpc ]
}


/******************************************
	Firewall configuration
 *****************************************/
module "firewall" {
  source        = "./modules/firewall_rule"
  project_id    = var.project_id
  ingress_rules = var.ingress_rules
  network_name  = var.network_name
  depends_on    = [ module.vpc ]
}


/******************************************
	Compute Instance configuration
 *****************************************/
module "compute_instance" {
  source              = "./modules/compute_instance"
  project_id          = var.project_id
  name                = var.name
  image               = var.image
  machine_type        = var.machine_type
  zone                = var.zone
  subnetwork          = var.subnetwork
  subnetwork_project  = var.subnetwork_project
  network             = var.network_name
  instance_group_name = var.instance_group_name
  depends_on          = [ module.subnets ]
}


/******************************************
	Router & Nat configuration
 *****************************************/

 module "nat" {
   source       = "./modules/cloud_nat"
   project_id   = var.project_id
   router_name  = var.router_name
   region       = var.region
   network      = var.network
   nat_name     = var.nat_name
   depends_on   = [ module.vpc ]
 }

 /******************************************
	Loadbalancer configuration
 *****************************************/

 module "Loadbalancer" {
  source                = "./modules/loadbalancer"
  project_id            = var.project_id
  network_name          = var.network_name
  ip_address            = var.ip_address
  target_name           = var.target_name
  url_map_name          = var.url_map_name
  path_rule             = var.path_rule
  backend_port_name     = var.backend_port_name
  backend_name          = var.backend_name
  group                 =  module.compute_instance.instance_group_id
  capacity_scaler       = var.capacity_scaler 
  max_rate_per_instance = var.max_rate_per_instance
  protocol              = var.protocol
  timeout_sec           = var.timeout_sec
  health_checks_name    = var.health_checks_name
  check_interval_sec    = var.check_interval_sec
  health_checks_port    = var.health_checks_port
 }

  /******************************************
	SQL configuration
 *****************************************/
 module "sql" {
  source                      = "./modules/cloud_sql"
  project_id                  = var.project_id
  region                      = var.region
  private_ip_address_name     = var.private_ip_address_name
  network_name                = var.network_name
  database_version            = var.database_version
  tier                        = var.tier
  private_network_id          = module.vpc.google_compute_network_id
  depends_on                  = [ module.vpc ]
 }