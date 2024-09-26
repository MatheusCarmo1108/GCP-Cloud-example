# Source
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_managed_zone
resource "google_dns_managed_zone" "private-zone" {
  name        = "development.test"
  dns_name    = "development-test"
  description = "DNS para uso de pods internos à API"
  labels = {
    environment = var.ENV
  }

  visibility = "private"

  private_visibility_config {
    networks {
      network_url = google_compute_network.vpc.id
    }
  }
}

# Source
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_record_set
# first
resource "google_dns_record_set" "first-rrset" {
  name = "first.${google_dns_managed_zone.private-zone.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.private-zone.name

  rrdatas = [google_compute_address.nginx-ingress-controller-internal-static-ip.address]
}

# second
resource "google_dns_record_set" "second-rrset" {
  name = "second.${google_dns_managed_zone.private-zone.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.private-zone.name

  rrdatas = [google_compute_address.nginx-ingress-controller-internal-static-ip.address]
}

# third
resource "google_dns_record_set" "third-rrset" {
  name = "third.${google_dns_managed_zone.private-zone.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.private-zone.name

  rrdatas = [google_compute_address.nginx-ingress-controller-internal-static-ip.address]
}

# fourth
resource "google_dns_record_set" "fourth-rrset" {
  name = "fourth.${google_dns_managed_zone.private-zone.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.private-zone.name

  rrdatas = [google_compute_address.nginx-ingress-controller-internal-static-ip.address]
}

# fifth
resource "google_dns_record_set" "fifth-rrset" {
  name = "fifth.${google_dns_managed_zone.private-zone.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.private-zone.name

  rrdatas = [google_compute_address.nginx-ingress-controller-internal-static-ip.address]
}
