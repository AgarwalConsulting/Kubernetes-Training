locals {
  vm_ips = {
    for i in range(var.instance_count) : i => [
      google_compute_instance.gcp_vm_101[i].network_interface.0.access_config.0.nat_ip
    ]
  }
}

output compute-instance {
  value = local.vm_ips
}
