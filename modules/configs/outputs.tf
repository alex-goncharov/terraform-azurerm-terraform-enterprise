output "primary_cloud_inits" {
  value = {
    for i in var.primaries :
    i => data.template_cloudinit_config.config[i].rendered
  }
  description = "map(string) of rendered cloud-init templates to pass to primary instances."
}

output "secondary_cloud_init" {
  value       = data.template_cloudinit_config.config_secondary.rendered
  description = "Rendered cloud-init template to pass to secondary scaling-set."
}

output "console_password" {
  value       = random_pet.console_password.id
  description = "The generated password for the admin console."
}

output "encryption_password" {
  value       = local.encryption_password
  description = "The Encryption Password is used to protect the vault unseal key and root token when the internal Vault is used."
}
