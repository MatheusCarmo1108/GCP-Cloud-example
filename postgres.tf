# medium example
# https://medium.com/swlh/how-to-deploy-a-cloud-sql-db-with-a-private-ip-only-using-terraform-e184b08eca64

# source
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance
resource "google_sql_database_instance" "api-postgres" {
  provider = google-beta

  name             = "${var.ENV}-postgres-${random_string.random_suffix.result}"
  database_version = "POSTGRES_15"
  region           = var.REGION
  project          = var.PROJECT_ID

  deletion_protection = false
  settings {
    database_flags {
      name  = "log_min_duration_statement" 
      value = "3000" 
    }
    location_preference {
      zone = var.ZONE
    }
    maintenance_window {
      hour = 0 
    }
    insights_config {
      query_insights_enabled  = true
      record_application_tags = true 
      record_client_address   = true 
    }
    tier = "db-custom-2-7680" # more here https://github.com/hashicorp/terraform/issues/12617#issuecomment-298617855
    disk_size = "137"
    disk_type = "PD_SSD"

    ip_configuration {
      ipv4_enabled    = "true"
      private_network = google_compute_network.vpc.self_link
      authorized_networks {
        name  = "API Dev Master" 
        value = "${google_container_cluster.gke-main-cluster.endpoint}/32" 
      }
    }
  }
  depends_on = [google_service_networking_connection.private_vpc_connection]
}


resource "google_sql_database" "database_first" {
  name     = "database_1"
  instance = google_sql_database_instance.api-postgres.name
  project = var.PROJECT_ID
}

resource "google_sql_database" "database_second" {
  name     = "database_2"
  instance = google_sql_database_instance.api-postgres.name
  project = var.PROJECT_ID
}
