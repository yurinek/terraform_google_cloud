# typically this file can also be named resources.tf


resource "google_compute_instance" "vm_instance" {
  count                 = var.instance_number_module_var
  name                  = "vm-${var.compute_name_module_var}-${count.index + 1}"
  machine_type          = var.compute_type_module_var

  boot_disk {
    initialize_params {
      # to find right image: gcloud compute images list |grep -i ubuntu
      image = var.compute_image_module_var
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
    ssh-keys = "${var.os_user_module_var}:${file("~/.ssh/id_rsa.pub")}"
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


resource "google_compute_disk" "default" {
  count = var.instance_number_module_var
  name  = "storage-${var.disk_ssd_name_module_var}-${count.index + 1}"
  type  = "pd-ssd"
  zone  = var.zone_module_var
  image = var.compute_image_module_var
  # If you specify size along with image or snapshot, the value must not be less than the size of the image or the size of the snapshot
  # (Optional) Size of the persistent disk, specified in GB
  size  = var.disk_ssd_size_module_var
  labels = {
    environment = "dev"
  }
  physical_block_size_bytes = 4096
}


resource "google_compute_attached_disk" "default" {
  count    = var.instance_number_module_var
  disk     = google_compute_disk.default[count.index].id
  instance = google_compute_instance.vm_instance[count.index].id
}


resource "google_compute_network" "vpc_network" {
  name                    = var.network_name_module_var
  auto_create_subnetworks = "true"
}


resource "google_compute_firewall" "default" {
  name = "ssh-firewall-rule"
  network = var.network_name_module_var
  allow {
    protocol = "tcp"
    ports = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]

  depends_on = [
    google_compute_network.vpc_network,
  ]
}
