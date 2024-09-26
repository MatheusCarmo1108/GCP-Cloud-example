# GKE cluster
# source
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster

resource "google_container_cluster" "gke-first-cluster" {
  name     = "first-gke"
  location = var.ZONE # --zone
  project = var.PROJECT_ID # --project

  remove_default_node_pool = true
  initial_node_count       = var.GKE_NUM_NODES # --num-nodes

  # --network and --subnetwork
  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnets.name

  monitoring_service = "none"

  workload_identity_config {
    workload_pool = "${var.ENV}.svc.id.goog"
  }
  # --cluster-secondary-range-name and --services-secondary-range-name
  ip_allocation_policy {
    cluster_secondary_range_name = google_compute_subnetwork.subnets.secondary_ip_range[0].range_name
    services_secondary_range_name = google_compute_subnetwork.subnets.secondary_ip_range[1].range_name
  }

  # --enable-master-authorized-networks
  master_authorized_networks_config {
    cidr_blocks {
      cidr_block = "${google_compute_instance.bastion.network_interface[0].access_config[0].nat_ip}/32"
      display_name = "Bastion IP"
    }

  }

  private_cluster_config {
    enable_private_endpoint = false # if true, don't allow external access
                                    # more: https://stackoverflow.com/questions/57548376/creating-a-private-cluster-in-gke-terraform-vs-console
    enable_private_nodes    = true # --enable-private-nodes
    master_ipv4_cidr_block  = "10.5.0.0/28" # --master-ipv4-cidr
  }

  # --no-enable-basic-auth \
#  master_auth {
#    password = ""
#    username = ""
#
#    # --issue-client-certificate
#    client_certificate_config {
#      issue_client_certificate = false
#    }
#  }

}

resource "google_container_cluster" "gke-first-cluster" {
  name     = "secondary-gke"
  location = var.ZONE # --zone
  project = var.PROJECT_ID # --project

  remove_default_node_pool = true
  initial_node_count       = var.GKE_NUM_NODES # --num-nodes

  # --network and --subnetwork
  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnets.name

  monitoring_service = "none"

  # --cluster-secondary-range-name and --services-secondary-range-name
  ip_allocation_policy {
    cluster_secondary_range_name = google_compute_subnetwork.subnets.secondary_ip_range[2].range_name
    services_secondary_range_name = google_compute_subnetwork.subnets.secondary_ip_range[3].range_name
  }

  # --enable-master-authorized-networks
  # --enable-master-authorized-networks
  master_authorized_networks_config {
    cidr_blocks {
      cidr_block = "${google_compute_instance.bastion.network_interface[0].access_config[0].nat_ip}/32"
      display_name = "Bastion IP"
    }
  }

  private_cluster_config {
    enable_private_endpoint = false # if true, don't allow external access
                                    # more: https://stackoverflow.com/questions/57548376/creating-a-private-cluster-in-gke-terraform-vs-console
    enable_private_nodes    = true # --enable-private-nodes
    master_ipv4_cidr_block  = "10.105.0.0/28" # --master-ipv4-cidr
  }

  # --no-enable-basic-auth \
#  master_auth {
#    password = ""
#    username = ""
#
#    # --issue-client-certificate
#    client_certificate_config {
#      issue_client_certificate = false
#    }
#  }

}
