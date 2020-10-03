// A variable for extracting the external IP address of the instance
output "public_ip_address" {
 # standard syntax:
 # value = google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip
 # gives error:
 # Because google_compute_instance.vm_instance has "count" set, its attributes must be accessed on specific instances
 # because of bug https://github.com/hashicorp/terraform/issues/16726
 value = "${element(concat(google_compute_instance.vm_instance.*.network_interface.0.access_config.0.nat_ip, list("")), 0)}"
}


