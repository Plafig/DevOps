resource "google_container_cluster" "primary" {
  name     = "my-gke-cluster"
  location = "europe-west1-b" # if provide region it will be highly available but more expensive.

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "my-node-pool"
  location   = "europe-west1-b"
  cluster    = google_container_cluster.primary.id
  node_count = 2

  node_config {
    preemptible  = true
    machine_type = "e2-small"

  }
}
