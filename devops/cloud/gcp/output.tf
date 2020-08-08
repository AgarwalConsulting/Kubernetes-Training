locals {
  worker_ips = {
    for i in range(var.instance_count) : i => [
      google_compute_instance.gcp_101_worker[i].network_interface.0.access_config.0.nat_ip
    ]
  }
}

output compute-instance-ip {
  value = google_compute_instance.gcp_101_control.network_interface.0.access_config.0.nat_ip
}

output compute-instance-ips {
  value = local.worker_ips
}
