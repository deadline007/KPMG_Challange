project_id                             = "solution-kit-1"
network_name                           = "test"
auto_create_subnetworks                = "false"
routing_mode                           = "GLOBAL"
description                            = ""
delete_default_internet_gateway_routes = "true"
mtu                                    = "1460"
    subnets = [
        {
            subnet_name                = "subnet-01"
            subnet_ip                  = "10.10.10.0/24"
            subnet_region              = "us-central1"
        },
    ] 
 ingress_rules = [{
    name                               = "allow-ssh-ingress"
    description                        = null
    direction                          = "INGRESS"
    priority                           = null
    ranges                             = ["10.0.0.0/8"]
    source_ranges                      = ["10.10.10.0/24"]
    source_tags                        = null
    source_service_accounts            = null
    target_tags                        = null
    target_service_accounts            = null
    allow                              = [{
      protocol                  = "tcp"
      ports                     = ["22"]
    }]
    deny                               = []
    log_config                         = {
      metadata                         = "INCLUDE_ALL_METADATA"
    }
  }]
 
name                                   = "test"
machine_type                           = "n1-standard-1"
image                                  = "debian-11-bullseye-v20230711"
region                                 = "us-central1"
zone                                   = "us-central1-a"
subnetwork                             = "subnet-01"
subnetwork_project                     = "solution-kit-1"
instance_group_name                    = "test"

router_name                            = "test"
network                                = "test"
nat_name                               = "test"

ip_address                             = "0.0.0.0"
target_name                            = "target-proxy"
url_map_name                           = "url-map-target-proxy"
path_rule                              = [ "/*" ]
backend_name                           = "backend"
backend_port_name                      = "http"
protocol                               = "HTTP"
timeout_sec                            = 10
  balancing_mode          = "RATE"
  capacity_scaler         = 0.4
  max_rate_per_instance   = 50
health_checks_name        = "check-backend"
check_interval_sec                      = 20
health_checks_port                      = 1


private_ip_address_name                 = "private-ip-address"
private_vpc_connection_name             = "value"
database_version                        = "MYSQL_5_6"
tier                                    = "db-f1-micro"