resource "google_compute_address" "bastion-host-static-ip" {
  name = "bastion-host-address"
  project      = var.PROJECT_ID
  region        = var.REGION
}

resource "google_compute_address" "timescale-host-static-ip" {
  name = "timescale-db-host-address"
  project      = var.PROJECT_ID
  region        = var.REGION
}

resource "google_compute_address" "nginx-ingress-controller-external-static-ip" {
  name = "nginx-ingress-controller-external-address"
  project      = var.PROJECT_ID
  region        = var.REGION
}

resource "google_compute_address" "nginx-ingress-controller-internal-static-ip" {
  name = "nginx-ingress-controller-internal-address"
  project      = var.PROJECT_ID
  region        = var.REGION
  address_type  = "INTERNAL"
  subnetwork    = google_compute_subnetwork.subnets.name
  purpose = "GCE_ENDPOINT"
}

resource "google_compute_address" "nginx-ingress-controller-iad-external-static-ip" {
  name = "nginx-ingress-controller-iad-external-address"
  project      = var.PROJECT_ID
  region        = var.REGION
}
resource "google_compute_address" "nginx-ingress-controller-iad-internal-static-ip" {
  name = "nginx-ingress-controller-iad-internal-address"
  project      = var.PROJECT_ID
  region        = var.REGION
  address_type  = "INTERNAL"
  subnetwork    = google_compute_subnetwork.subnets.name
  purpose = "GCE_ENDPOINT"
}

# db usage
# user MUST have all IAM listed below
# https://cloud.google.com/sql/docs/postgres/configure-private-ip
resource "google_compute_global_address" "database_private_ip_address" {
    provider      = google-beta
    description   = "IP Range for peer networks."
    name          = "google-managed-services-bmd-vpc-for-database-conn"
    purpose       = "VPC_PEERING"
    address_type  = "INTERNAL"
    prefix_length = 20
    network       = google_compute_network.vpc.self_link
}
