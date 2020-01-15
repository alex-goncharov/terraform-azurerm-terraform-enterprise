resource "azurerm_network_interface" "primary" {
  for_each            = var.cloud_init_data
  name                = "${local.prefix}-${each.key}"
  resource_group_name = var.rg_name
  location            = var.location

  ip_configuration {
    name                          = local.ip_conf_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    primary                       = true
  }

  tags = {
    "Name" = local.prefix
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "ptfe_api" {
  for_each                = var.cloud_init_data
  network_interface_id    = azurerm_network_interface.primary[each.key].id
  ip_configuration_name   = local.ip_conf_name
  backend_address_pool_id = var.cluster_backend_pool_id
}

