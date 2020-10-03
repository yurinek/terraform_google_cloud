// A variable for extracting the external IP address of the instance
output "ip" {
 value = google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip
}

output "ip2" {
 value = google_compute_instance.vm_instance_project_wide_ssh_keys.network_interface.0.access_config.0.nat_ip
}


# following outputs should help to generate local ~/.kube/config for k8s auth


output "client_key" {
  value       = "${google_container_cluster.my-gke-cluster.master_auth.0.client_key}"
  description = "Base64 encoded private key used by clients to authenticate to the cluster endpoint"
}

output "client_certificate" {
  value       = "${google_container_cluster.my-gke-cluster.master_auth.0.client_certificate}"
  description = "Base64 encoded public certificate used by clients to authenticate to the cluster endpoint"
}

output "cluster_ca_certificate" {
  value       = "${google_container_cluster.my-gke-cluster.master_auth.0.cluster_ca_certificate}"
  description = "Base64 encoded public certificate that is the root of trust for the cluster"
}

output "cluster_name" {
  value       =  "${google_container_cluster.my-gke-cluster.name}"
  description =  "The full name of this Kubernetes cluster"
}

