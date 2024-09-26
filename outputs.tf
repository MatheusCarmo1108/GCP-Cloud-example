output "kubernetes_cluster_name" {
  value       = google_container_cluster.gke-first-cluster.name
  description = "GKE Cluster Name"
}

output "kubernetes_cluster_host" {
  value       = google_container_cluster.gke-first-cluster.endpoint
  description = "GKE Cluster Host"
}

output "bastion-external-ip" {
  description = "Bastion IP"
  value = google_compute_instance.bastion.network_interface[0].access_config[0].nat_ip
}
