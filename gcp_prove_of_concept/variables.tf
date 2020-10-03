# variable declaration blocks (which can actually appear in any .tf file, but are in variables.tf by convention) declare that a variable exists


provider "google" {
  project = "your-gcp-project-name"
  region  = "EU"
  zone    = "europe-west3-a"
}

variable "os_user" {
  description = "Deploy ssh public keys to this os user"
  type        = string
  default     = "your-os-user"
}

variable "project_wide_os_user" {
  description = "Deploy ssh public key to this os user on every vm in project"
  type        = string
  default     = "important_user"
}

variable "compute_name" {
  description = "Deploy vm with this name"
  type        = string
  default     = "terraform-vm"
}

variable "compute_type" {
  description = "Deploy vm with this type"
  type        = string
  default     = "f1-micro"
}

variable "network_name" {
  description = "Deploy network with this name"
  type        = string
  default     = "terraform-net"
}

variable "compute_image" {
  description = "Deploy vm with this OS image"
  type        = string
  default     = "ubuntu-os-cloud/ubuntu-minimal-2004-lts"  
}

# bucket name needs to be unique across all gcp users
variable "bucket_name" {
  description = "Deploy bucket with this name"
  type        = string
  default     = "yurinek-bucket-users"  
}

variable "disk_ssd_name" {
  description = "Deploy ssd disk with this name"
  type        = string
  default     = "disk-ssd-01"  
}

variable "disk_ssd_size" {
  description = "Deploy ssd disk with this size"
  type        = number
  default     = 100
}

variable "zone" {
  description = "Deploy objects in this availibility zone"
  type        = string
  default     = "europe-west3-a"  
}


variable "k8s_cluster_name" {
  description = "Deploy Kubernetes cluster with this name"
  type        = string
  default     = "myapp-cluster"  
}

variable "k8s_cluster_name_net_conf" {
  description = "Deploy Kubernetes cluster for network configuration with this name"
  type        = string
  default     = "myapp-cluster-net"  
}

variable "k8s_node_pool_name" {
  description = "Deploy Kubernetes node pool with this name"
  type        = string
  default     = "myapp-k8s-node-pool"  
}

variable "k8s_node_pool_autoscaling_max_node_count" {
  description = "Scale Kubernetes node pool upto this number of nodes"
  type        = number
  default     = 10  
}

variable "k8s_node_pool_autoscaling_min_node_count" {
  description = "Scale Kubernetes node pool from this number of nodes"
  type        = number
  default     = 2  
}

variable "k8s_compute_type" {
  description = "Deploy vm with this type"
  type        = string
  default     = "e2-medium"
}

