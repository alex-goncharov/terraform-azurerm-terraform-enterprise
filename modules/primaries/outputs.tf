output "network_interfaces" {
  value = {
    for k, v in var.cloud_init_data :
    k => azurerm_network_interface.primary[k].id
  }
  description = "List of ids of Azure Network Interface objects tied to the primary vms."
}

output "ip_conf_name" {
  value       = local.ip_conf_name
  description = "The name of the IP Configuration object for the Azure Network Interfaces for the primary vms."
}

