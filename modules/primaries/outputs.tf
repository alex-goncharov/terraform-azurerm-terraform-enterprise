output "network_interfaces" {
  value       = azurerm_network_interface.primary.*.id
  description = "List of ids of Azure Network Interface objects tied to the primary vms."
}

output "ip_conf_name" {
  value       = local.ip_conf_name
  description = "The name of the IP Configuration object for the Azure Network Interfaces for the primary vms."
}

