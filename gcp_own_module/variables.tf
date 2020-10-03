# variable declaration blocks (which can actually appear in any .tf file, but are in variables.tf by convention) declare that a variable exists


provider "google" {
  project = "your-gcp-project-name"
  region  = "EU"
  zone    = "europe-west3-a"
}

variable "instance_number_root_var" {
  description = "Deploy so many vm instances as defined in this var"
  type        = number
  default     = 3
}

variable "os_user_root_var" {
  description = "Deploy ssh public keys to this os user"
  type        = string
  default     = "your-os-user-name"
}

variable "compute_name_root_var" {
  description = "Deploy vm with this name"
  type        = string
  default     = "terraform"
}

variable "compute_type_root_var" {
  description = "Deploy vm with this type"
  type        = string
  default     = "f1-micro"
}

variable "network_name_root_var" {
  description = "Deploy network with this name"
  type        = string
  default     = "terraform-net"
}

variable "compute_image_root_var" {
  description = "Deploy vm with this OS image"
  type        = string
  default     = "ubuntu-os-cloud/ubuntu-minimal-2004-lts"  
}

variable "disk_ssd_name_root_var" {
  description = "Deploy ssd disk with this name"
  type        = string
  default     = "disk-ssd"  
}

variable "disk_ssd_size_root_var" {
  description = "Deploy ssd disk with this size"
  type        = number
  default     = 100
}

variable "zone_root_var" {
  description = "Deploy objects in this availibility zone"
  type        = string
  default     = "europe-west3-a"  
}

