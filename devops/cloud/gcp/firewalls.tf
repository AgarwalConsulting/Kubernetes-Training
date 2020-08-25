resource "google_compute_firewall" "k8s-internal-rule" {
  project       = var.project_id
  name          = "gcp-k8s-cluster-rule"
  network       = google_compute_network.gcp_101.name
  # network = "default"

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "udp"
  }

  allow {
    protocol = "ipip"
  }

  // allows internal communication across TCP, UDP, ICMP and IP in IP
  source_ranges = [
    "10.240.0.0/24",
  ]

  target_tags = [
    "k8s-nodes",
  ]
}

resource "google_compute_firewall" "k8s-external-rule" {
  project = var.project_id
  name    = "gcp-k8s-public-rule"
  network = google_compute_network.gcp_101.name
  # network = "default"

  allow {
    protocol = "tcp"
    ports = [
      "22",
      "80",
      "5000",
      "6443",
      "8000",
      "8080",
      "30080"
    ]
  }

  allow {
    protocol = "icmp"
  }

  // Allow traffic from everywhere to instances with an k8s-nodes tag
  source_ranges = [
    "0.0.0.0/0",
  ]

  target_tags = [
    "k8s-nodes",
  ]
}
