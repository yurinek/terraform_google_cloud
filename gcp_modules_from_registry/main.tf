# create network

module "vpc" {
    source  = "terraform-google-modules/network/google"
    version = "~> 2.5"

    project_id   = var.project_id
    network_name = var.network_name
    routing_mode = "GLOBAL"

    subnets = [
        {
            subnet_name           = var.subnet_name1
            subnet_ip             = var.subnet_ip1
            subnet_region         = var.region
        },
        {
            subnet_name           = var.subnet_name2
            subnet_ip             = var.subnet_ip2
            subnet_region         = var.region
            subnet_private_access = "true"
            subnet_flow_logs      = "true"
            description           = "This subnet has a description"
        },
        {
            subnet_name               = var.subnet_name3
            subnet_ip                 = var.subnet_ip3
            subnet_region             = var.region
            subnet_flow_logs          = "true"
            subnet_flow_logs_interval = "INTERVAL_10_MIN"
            subnet_flow_logs_sampling = 0.7
            subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
        }
    ]

}


# create bucket

module "gcs_buckets" {
  source  = "terraform-google-modules/cloud-storage/google"
  version = "~> 1.7"
  project_id  = var.project_id
  names = var.bucket_names
  prefix = var.bucket_prefix
  versioning = {
    first = true
  }
}


