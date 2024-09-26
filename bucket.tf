resource "random_string" "random_suffix" {
  length  = 8
  special = false
  upper   = false
}

resource "google_storage_bucket" "api-bucket" {
  name          = "${var.ENV}-${random_string.random_suffix.result}"
  force_destroy = true
  project = var.PROJECT_ID
  location = var.REGION
}
