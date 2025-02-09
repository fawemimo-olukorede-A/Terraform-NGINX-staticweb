resource "azurerm_windows_virtual_machine" "vm" {
  for_each = { for x in var.config.vm : x.name => x }

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = coalesce(each.value.location, "UK South")
  size                = coalesce(each.value.size, "Standard_D8s_v3")
  admin_username      = coalesce(each.value.admin_username, "finopay")
  admin_password      = each.value.admin_password
  network_interface_ids = each.value.network_interface_ids

  os_disk {
    caching              = coalesce(each.value.os_disk.caching, "ReadWrite")
    storage_account_type = coalesce(each.value.os_disk.storage_account_type, "Standard_LRS")
  }

  source_image_reference {
    publisher = coalesce(each.value.source_image_reference.publisher, "MicrosoftWindowsServer")
    offer     = coalesce(each.value.source_image_reference.offer, "WindowsServer")
    sku       = coalesce(each.value.source_image_reference.sku, "2022-Datacenter")
    version   = coalesce(each.value.source_image_reference.version, "latest")
  }

  tags = each.value.tags
}