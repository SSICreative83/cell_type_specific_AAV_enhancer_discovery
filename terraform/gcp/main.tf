provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_container_cluster" "primary" {
  name     = "scrna-omics-cluster"
  location = var.region

  initial_node_count = 1
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "default-pool"
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = 3

  node_config {
    machine_type = "e2-medium"

    oauth
