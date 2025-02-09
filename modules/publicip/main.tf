resource "azurerm_public_ip" "publicip" {
  for_each            = { for x in var.config.public-ip : x.name => x }
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  allocation_method   = each.value.allocation_method
  sku                 = each.value.sku
  sku_tier            = each.value.sku_tier
}