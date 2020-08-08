resource "google_compute_network" "gcp_101" {
  name = "gcp-101"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "k8s_nodes" {
  name = "k8s-nodes"
  ip_cidr_range = "10.240.0.0/24"
  network       = google_compute_network.gcp_101.name
}
