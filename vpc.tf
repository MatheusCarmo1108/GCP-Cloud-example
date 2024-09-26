resource "google_compute_network" "vpc" {
  name                    = "vpc"
  auto_create_subnetworks = "false" //allow user to create own subnetworks
}

resource "google_compute_subnetwork" "subnets" {
  name          = "subnet"
  ip_cidr_range = "10.2.0.0/20"
  region        = var.REGION
  network       = google_compute_network.vpc.name
  project = var.PROJECT_ID

  private_ip_google_access = true

  # First Cluster
  secondary_ip_range {
    range_name    = "${google_compute_network.vpc.name}-pods"
    ip_cidr_range = "10.4.0.0/20"
  }
  secondary_ip_range {
    range_name    = "${google_compute_network.vpc.name}-services"
    ip_cidr_range = "10.8.0.0/20"
  }

  # Second Cluster
  secondary_ip_range {
    range_name    = "${google_compute_network.vpc.name}-iad-pods"
    ip_cidr_range = "10.104.0.0/20"
  }
  secondary_ip_range {
    range_name    = "${google_compute_network.vpc.name}-iad-services"
    ip_cidr_range = "10.108.0.0/20"
  }
}

resource "google_compute_router" "router" {
  name    = "router"
  region  = google_compute_subnetwork.subnets.region
  network = google_compute_network.vpc.id

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "nat" {
  name                               = "nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

resource "google_service_networking_connection" "private_vpc_connection" {
    provider    = google-beta
    network       = google_compute_network.vpc.self_link
    service       = "servicenetworking.googleapis.com"
    reserved_peering_ranges = [google_compute_global_address.database_private_ip_address.name]
}