# Source
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool

resource "google_container_node_pool" "first-pool" {
  name       = "first-pool"
  location   = var.ZONE
  cluster    = google_container_cluster.gke-first-cluster.name
  initial_node_count = var.GKE_NUM_NODES
  project = var.PROJECT_ID

  autoscaling {
    max_node_count = 5
    min_node_count = 1
  }

  management {
    auto_repair = true
    auto_upgrade = true
  }

  max_pods_per_node = 30

  node_config {
    preemptible  = true
    machine_type = "n1-standard-1"
    disk_size_gb = 50
    labels = {
      env = var.ENV
    }
    tags         = ["${var.ENV}-node", "${var.ENV}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
    workload_metadata_config  {
      mode = "GKE_METADATA"
    }
  }
}

resource "google_container_node_pool" "second-pool" {
  name       = "second-pool"
  location   = var.ZONE
  cluster    = google_container_cluster.gke-first-cluster.name
  initial_node_count = var.GKE_NUM_NODES
  project = var.PROJECT_ID

  autoscaling {
    max_node_count = 5
    min_node_count = 1
  }

  management {
    auto_repair = true
    auto_upgrade = true
  }

  max_pods_per_node = 30

  node_config {
    preemptible  = true
    machine_type = "n1-standard-2"
    disk_size_gb = 50
    labels = {
      env = var.ENV
    }
    tags         = ["${var.ENV}-node", "${var.ENV}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
    workload_metadata_config  {
      mode = "GKE_METADATA"
    }
  }
}

resource "google_container_node_pool" "third-pool" {
  name       = "third-pool"
  location   = var.ZONE
  cluster    = google_container_cluster.gke-first-cluster.name
  initial_node_count = var.GKE_NUM_NODES
  project = var.PROJECT_ID

  autoscaling {
    max_node_count = 2
    min_node_count = 1
  }

#  management {
#    auto_repair = true
#    auto_upgrade = true
#  }

  max_pods_per_node = 30

  node_config {
    preemptible  = true
    machine_type = "n1-standard-2"
    disk_size_gb = 50
    labels = {
      env = var.ENV
    }
    tags         = ["${var.ENV}-node", "${var.ENV}-gke", "datad-pool"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
    workload_metadata_config  {
      mode = "GKE_METADATA"
    }
  }
}

resource "google_container_node_pool" "fourth-pool" {
  name       = "fourth-pool"
  location   = var.ZONE
  cluster    = google_container_cluster.gke-second-cluster.name
  initial_node_count = 2
  project = var.PROJECT_ID

  autoscaling {
    max_node_count = 3
    min_node_count = 1
  }

#  management {
#    auto_repair = true
#    auto_upgrade = true
#  }

  max_pods_per_node = 30

  node_config {
    preemptible  = true
    machine_type = "n1-standard-2"
    disk_size_gb = 50
    labels = {
      env = var.ENV
    }
    tags         = ["${var.ENV}-node", "${var.ENV}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
    workload_metadata_config  {
      mode = "GKE_METADATA"
    }
  }
}

resource "google_container_node_pool" "fifth-pool" {
  name       = "fifth-pool"
  location   = var.ZONE
  cluster    = google_container_cluster.gke-second-cluster.name
  initial_node_count = var.GKE_NUM_NODES
  project = var.PROJECT_ID

  autoscaling {
    max_node_count = 1
    min_node_count = 1
  }

#  management {
#    auto_repair = true
#    auto_upgrade = true
#  }

  max_pods_per_node = 30

  node_config {
    preemptible  = true
    machine_type = "n1-standard-2"
    disk_size_gb = 50
    labels = {
      env = var.ENV
    }
    tags         = ["${var.ENV}-node", "${var.ENV}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
    workload_metadata_config  {
      mode = "GKE_METADATA"
    }
  }
}

