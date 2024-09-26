resource "google_compute_firewall" "instances-ssh" {
  name    = "-ssh"
  description = "Allow comm at port 22 on instances"
  network = google_compute_network.vpc.name
  project = var.PROJECT_ID

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  direction = "INGRESS"
  priority = 900
  target_tags = ["${var.ENV}"]
}

resource "google_compute_firewall" "bastion-tunnel" {
  name    = "development-bastion-tunnel"
  description = "Allow comm at ports neede for bastion's tunnel"
  network = google_compute_network.vpc.name
  project = var.PROJECT_ID

  allow {
    protocol = "tcp"
    ports    = ["443","8441","8444"]
  }

  source_ranges = ["0.0.0.0/0"]
  direction = "INGRESS"
  priority = 900
  target_tags = ["${var.ENV}-bastion"]
}

resource "google_compute_firewall" "timescale-connect" {
  name = "timescale-connect-db"
  description = "Allow connection at port 5432 of TimescaleDB"
  network = google_compute_network.vpc.name 
  project = var.PROJECT_ID

  allow {
    protocol = "tcp"
    ports    = ["5432"]
  }

  source_ranges = ["10.4.0.0/20"]
  direction = "INGRESS"
  priority = 900 
  target_tags = ["timescale-db"]
}

resource "google_compute_firewall" "nginx-ingress-controller" {
  name    = "nginx-ingress-controller"
  description = "Allow comm at port 8443 for nginx ingress controller"
  network = google_compute_network.vpc.name
  project = var.PROJECT_ID

  allow {
    protocol = "tcp"
    ports    = ["8443"]
  }

  source_ranges = [google_container_cluster.gke-main-cluster.private_cluster_config[0].master_ipv4_cidr_block, google_container_cluster.gke-iad-cluster.private_cluster_config[0].master_ipv4_cidr_block]
  direction = "INGRESS"
  priority = 900
  target_tags = ["${var.ENV}-node"]
}

resource "google_compute_firewall" "pmt-adapter" {
  name    = "pmt-adapter"
  description = "Whitelist 6443 for prometheus adapter metrics API "
  network = google_compute_network.vpc.name
  project = var.PROJECT_ID

  allow {
    protocol = "tcp"
    ports    = ["6443"]
  }

  target_tags = ["${var.ENV}-node", "tools-pool"]

  source_ranges = ["0.0.0.0/0"]
  direction = "INGRESS"
  priority = 900
}

resource "google_compute_firewall" "pmt-operator" {
  name    = "pmt-operator"
  description = "Whitelist 9090 for prometheus operator metrics API "
  network = google_compute_network.vpc.name
  project = var.PROJECT_ID

  allow {
    protocol = "tcp"
    ports    = ["9090"]
  }

  target_tags = ["tools-pool"]

  source_ranges = ["0.0.0.0/0"]

  direction = "INGRESS"
  priority = 900
}


