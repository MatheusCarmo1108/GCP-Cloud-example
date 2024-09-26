

resource "google_compute_instance" "timescale-database" {
  name         = "timescaledb"
  machine_type = var.BASTION_MACHINE_TYPE
  zone         = var.ZONE
  project      = var.PROJECT_ID
  tags         = ["timescale-db", "${var.ENV}"]

  scheduling {
    preemptible = true
    automatic_restart = false
  }

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10" # more here https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_image
    }
  }

  allow_stopping_for_update = true

  network_interface {
    network = google_compute_network.vpc.name
    subnetwork = google_compute_subnetwork.subnets.name

    access_config {
      // Static IP
      nat_ip = google_compute_address.timescale-host-static-ip.address
    }
  }

  # add ssh key here
  # https://stackoverflow.com/questions/38645002/how-to-add-an-ssh-key-to-an-gcp-instance-using-terraform
  metadata = {
#    ssh-keys = "${var.GCE_LEARNING_USER}:${file(var.GCE_LEARNING_PUB_FILE)}"
    ssh-keys = join("\n", [for user, key in var.SSH_KEYS : "${user}:${key}"])
  }

  depends_on = [google_compute_firewall.instances-ssh]
}