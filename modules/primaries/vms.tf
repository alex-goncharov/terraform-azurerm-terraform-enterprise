resource "azurerm_virtual_machine" "primary" {
  # The number of primaries must be hard coded to 3 when Internal Production Mode
  # is selected. Currently, that mode does not support scaling. In other modes, the
  # cluster can be scaled according the primary_count variable.
  for_each                      = var.cloud_init_data
  name                          = "${local.prefix}-${each.key}"
  resource_group_name           = var.rg_name
  location                      = var.location
  vm_size                       = var.vm_size
  primary_network_interface_id  = azurerm_network_interface.primary[each.key].id
  network_interface_ids         = [azurerm_network_interface.primary[each.key].id]
  delete_os_disk_on_termination = true

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      key_data = var.ssh_key
      path     = "/home/${var.username}/.ssh/authorized_keys"
    }
  }

  os_profile {
    computer_name  = "${local.prefix}-${each.key}"
    admin_username = var.username
    custom_data    = each.value
  }

  os_profile_secrets {
    source_vault_id = var.key_vault["id"]

    vault_certificates {
      certificate_url = var.key_vault["cert_uri"]
    }
  }

  storage_os_disk {
    name          = "${local.prefix}-${each.key}"
    disk_size_gb  = var.os_disk_size
    os_type       = "Linux"
    create_option = "FromImage"
    caching       = "ReadWrite"
  }

  storage_image_reference {
    publisher = var.storage_image["publisher"]
    offer     = var.storage_image["offer"]
    sku       = var.storage_image["sku"]
    version   = var.storage_image["version"]
  }

  tags = {
    "Name" = local.prefix
  }
}

