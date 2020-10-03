


module "mymodule" {
  source                          = "./mymodule"
  instance_number_module_var      = var.instance_number_root_var
  compute_name_module_var         = var.compute_name_root_var
  compute_type_module_var         = var.compute_type_root_var
  network_name_module_var         = var.network_name_root_var
  compute_image_module_var        = var.compute_image_root_var
  os_user_module_var              = var.os_user_root_var
  zone_module_var                 = var.zone_root_var
  disk_ssd_name_module_var        = var.disk_ssd_name_root_var
  disk_ssd_size_module_var        = var.disk_ssd_size_root_var
}
