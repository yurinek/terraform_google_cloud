# typically this file can also be named resources.tf

# create virtual machine

resource "google_compute_instance" "vm_instance" {
  name         = var.compute_name
  machine_type = var.compute_type

  boot_disk {
    initialize_params {
      image = var.compute_image
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.self_link
    access_config {
      # Include this section to give the VM an external ip address
    }
  }

  # following gets executed on existing vms only after they get rebooted
  metadata = {
    ssh-keys = "${var.os_user}:${file("~/.ssh/id_rsa.pub")}"
    startup-script = <<SCRIPT
        apt-get -y update
        apt-get -y install tree
        touch /var/lib/tpm/touched
        SCRIPT
  }

  # in order to prevent conflicts between disk and vm over control of OS
  # only needed if persistent disk created with google_compute_attached_disk
  lifecycle {
    ignore_changes = [attached_disk]
  }

}


# create and attach persistent disk

resource "google_compute_disk" "default" {
  name  = var.disk_ssd_name
  type  = "pd-ssd"
  zone  = var.zone
  image = var.compute_image
  # If you specify size along with image or snapshot, the value must not be less than the size of the image or the size of the snapshot
  # (Optional) Size of the persistent disk, specified in GB
  size  = var.disk_ssd_size
  labels = {
    environment = "dev"
  }
  physical_block_size_bytes = 4096
}


resource "google_compute_attached_disk" "default" {
  disk     = google_compute_disk.default.id
  instance = google_compute_instance.vm_instance.id
}


# create network

resource "google_compute_network" "vpc_network" {
  name                    = var.network_name
  auto_create_subnetworks = "true"
}


# create firewall rule

resource "google_compute_firewall" "default" {
  name = "ssh-firewall-rule"
  network = var.network_name
  allow {
    protocol = "tcp"
    ports = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]

  depends_on = [
    google_compute_network.vpc_network,
  ]
}


# following demonstrates howto use project wide ssh keys


# project wide keys will be visible in https://console.cloud.google.com/compute/metadata/sshKeys?project=project-name
# existing project wide keys will be removed, include them here to keep them
resource "google_compute_project_metadata" "default" {
  metadata = {
    ssh-keys = "${var.project_wide_os_user}:${file("~/.ssh/id_rsa.pub")}"
  }
}


resource "google_compute_instance" "vm_instance_project_wide_ssh_keys" {
  name         = "${var.compute_name}-2"
  machine_type = var.compute_type

  # for this vm no existing persistent disk will be attached
  boot_disk {
    initialize_params {
      # to find right image: gcloud compute images list |grep -i ubuntu
      image = var.compute_image
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.self_link
    access_config {
      # Include this section to give the VM an external ip address
    }
  }

  metadata = {
    block-project-ssh-keys = false
  }

  # unlike in metadata.startup_script above, this method forces recreation of vm. above method will only be applied on existing vm after reboot of the vm.
  metadata_startup_script = "echo hi > /var/tmp/test.txt"

}


# create bucket

resource "google_storage_bucket" "default" {
  name                        = var.bucket_name
  location                    = "EU"
  force_destroy               = true
  uniform_bucket_level_access = true
}


# create GKE (k8s) cluster

resource "google_container_cluster" "my_vpc_native_cluster" {
  name               = var.k8s_cluster_name_net_conf
  location           = var.zone
  initial_node_count = 1

  network    = "default"
  subnetwork = "default"

}


resource "google_container_cluster" "my-gke-cluster" {
  name     = var.k8s_cluster_name
  location = var.zone

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
}


resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = var.k8s_node_pool_name
  location   = var.zone
  cluster    = google_container_cluster.my-gke-cluster.name

  # Configuration required by cluster autoscaler to adjust the size of the node pool to the current cluster usage.
  autoscaling {
    # Minimum number of nodes in the NodePool. Must be >=0 and <= max_node_count.
    min_node_count = var.k8s_node_pool_autoscaling_min_node_count

    # Maximum number of nodes in the NodePool. Must be >= min_node_count.
    max_node_count = var.k8s_node_pool_autoscaling_max_node_count
  }

  node_config {
    preemptible  = true
    machine_type = var.k8s_compute_type

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
