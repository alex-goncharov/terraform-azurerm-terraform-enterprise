output "backend_pool_ids" {
  value = concat(
    [azurerm_lb_backend_address_pool.azlb.id],
    var.snat_lb == null ? [] : [azurerm_lb_backend_address_pool.snat.id]
  )
  description = "The id of the backend pool for this loadbalancer."
}

output "public_ip_address" {
  value       = var.internal_lb ? [var.public_ip] : azurerm_public_ip.azlb.*.ip_address
  description = "The public ip address of this loadbalancer"
}

output "private_ip_address" {
  value       = azurerm_lb.azlb.private_ip_addresses
  description = "The private ip address of this loadbalancer"
}

output "public_ip_id" {
  value       = var.internal_lb ? "" : azurerm_public_ip.azlb.*.id[0]
  description = "The id of the public ip resource in Azure of this loadbalancer"
}

output "lb_endpoint_dns" {
  value       = "${azurerm_dns_a_record.api.name}.${azurerm_dns_a_record.api.zone_name}"
  description = "The api dns endpoint for this loadbalancer"
}

output "app_endpoint_dns" {
  value       = "${azurerm_dns_a_record.application.name}.${azurerm_dns_a_record.application.zone_name}"
  description = "The dns endpoint for this loadbalancer"
}

