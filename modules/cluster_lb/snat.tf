locals {
  snat_lb = {
    id                             = var.snat_lb == null ? azurerm_lb.azlb.id : var.snat_lb.id
    frontend_ip_configuration_name = var.snat_lb == null ? local.frontend : var.snat_lb.frontend_ip_configuration_name
  }
}
resource "azurerm_lb_backend_address_pool" "snat" {
  count               = var.snat_lb == null ? 0 : 1
  name                = local.prefix
  resource_group_name = var.rg_name
  loadbalancer_id     = var.snat_lb.id
}

resource "azurerm_lb_outbound_rule" "snat" {
  name                    = local.prefix
  resource_group_name     = var.rg_name
  loadbalancer_id         = local.snat_lb.id
  protocol                = "Tcp"
  backend_address_pool_id = azurerm_lb_backend_address_pool.snat.id

  frontend_ip_configuration {
    name = local.snat_lb.frontend_ip_configuration_name
  }
}
