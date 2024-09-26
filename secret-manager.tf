module "secret-manager" {
  source  = "GoogleCloudPlatform/secret-manager/google"
  version = "~> 0.2"
  project_id = var.PROJECT_ID
  secrets = var.secret_data
}