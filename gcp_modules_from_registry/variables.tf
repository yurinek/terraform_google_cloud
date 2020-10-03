

variable "project_id" {
  description = "Deploy resources in this project"
  type        = string
  default     = "your-project-name"
}

variable "network_name" {
  description = "Deploy resources in this network"
  type        = string
  default     = "network-production"
}

variable "subnet_name1" {
  description = "Deploy resources in this subnetwork"
  type        = string
  default     = "subnet-01"
}

variable "subnet_name2" {
  description = "Deploy resources in this subnetwork"
  type        = string
  default     = "subnet-02"
}

variable "subnet_name3" {
  description = "Deploy resources in this subnetwork"
  type        = string
  default     = "subnet-03"
}

variable "subnet_ip1" {
  description = "Create subnetwork with this ip"
  type        = string
  default     = "10.10.10.0/24"
}

variable "subnet_ip2" {
  description = "Create subnetwork with this ip"
  type        = string
  default     = "10.10.20.0/24"
}

variable "subnet_ip3" {
  description = "Create subnetwork with this ip"
  type        = string
  default     = "10.10.30.0/24"
}

variable "region" {
  description = "Deploy objects in this region"
  type        = string
  default     = "europe-west3"  
}

variable "zone" {
  description = "Deploy objects in this availibility zone"
  type        = string
  default     = "europe-west3-a"  
}

variable "bucket_names" {
  type    = list(string)
  default = ["your-bucket-01", "your-bucket-02"]
}

variable "bucket_prefix" {
  type    = string
  default = "my-unique-prefix"
}

