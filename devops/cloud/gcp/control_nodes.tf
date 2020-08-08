resource "google_compute_instance" "gcp_101_control" {
  project      = var.project_id
  zone         = var.zone
  name         = var.control_vm_name
  machine_type = "n1-standard-4"

  allow_stopping_for_update = true
  can_ip_forward = true

  boot_disk {
    initialize_params {
      size = 200
      image = data.google_compute_image.node.self_link
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    # network       = "default"
    subnetwork = google_compute_subnetwork.k8s_nodes.name
    access_config {
    }
    network_ip = "10.240.0.11"
  }

  service_account {
    scopes = [ "compute-rw", "storage-ro", "service-management", "service-control", "logging-write", "monitoring" ]
  }

  metadata = {
    ssh-keys = "gcp:${file(var.publickeyfile)}"
  }

  metadata_startup_script = data.template_cloudinit_config.config.rendered

  tags = [
    "k8s-nodes",
    "k8s-control",
  ]
}
