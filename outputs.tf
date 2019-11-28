output "application_endpoint" {
  value       = "https://${module.cluster_lb.app_endpoint_dns}"
  description = "The URI for accessing the application."
}

output "application_health_check" {
  value       = "http://${module.cluster_lb.app_endpoint_dns}/_health_check"
  description = "The URI for the application health checks."
}

output "install_id" {
  value       = random_string.install_id.result
  description = "The string prefix for resources."
}

output "installer_dashboard_endpoint" {
  value       = "https://${module.cluster_lb.app_endpoint_dns}:8800"
  description = "The URI for accessing the backend console."
}

output "installer_dashboard_password" {
  value       = module.configs.console_password
  description = "Generated password to unlock the installer dashboard."
}

output "lb_private_ip" {
  value       = module.cluster_lb.private_ip_address
  description = "Cluster LB private IP address"
}

output "ssh_private_key" {
  value       = module.common.ssh_private_key_path
  description = "Path to the private key used for ssh authorization."
}
