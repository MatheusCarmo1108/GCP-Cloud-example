terraform {
  # required_version = "~> 0.14"
  required_providers {
    google = {
      source = "hashicorp/google"
      # version = "~>4.10.0"
    }
  }
}

provider "google" {

  credentials = file(var.CREDENTIALS_FILE)

  project = var.PROJECT_ID
  region  = var.REGION
  zone    = var.ZONE

}

provider "google-beta" {

  credentials = file(var.CREDENTIALS_FILE)

  project = var.PROJECT_ID
  region  = var.REGION
  zone    = var.ZONE

}
