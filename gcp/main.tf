provider "google" {
  credentials = file(var.credentials_file_path)
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

#resource "google_project" "project" {
#  name       = var.project_name
#  project_id = var.project_id
#  billing_account     = var.billing_acct_id
#}

resource "google_compute_network" "vpc" {
  name                    = "${var.project_name}-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "${var.project_name}-subnet"
  region        = var.region
  network       = google_compute_network.vpc.id
  ip_cidr_range = var.vpc_cidr
}

resource "google_compute_instance" "vm" {
  name         = "${var.project_name}-vm"
  machine_type = var.vm_size
  zone         = var.zone
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11-bullseye-v20231212"
    }
  }
  network_interface {
    network    = google_compute_network.vpc.id
    subnetwork = google_compute_subnetwork.subnet.id
    access_config {
      // Assigns a public IP address
    }
  }
}
