# value references module.modulename.variable_name_from_outputs.tf 

output "public_ip_address" {
  description = "public ip addresses of the vm"
  value       = module.mymodule.public_ip_address
}






