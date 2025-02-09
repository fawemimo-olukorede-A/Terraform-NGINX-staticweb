resource "azurerm_virtual_network" "vnet" {
  for_each            = { for x in var.config.vnet : x.name => x }
  address_space       = each.value.address_space
  location            = each.value.location
  name                = length(each.value.vnet_prefix) > 0 ? "${each.value.vnet_prefix}-${each.value.name}" : each.value.name
  resource_group_name = each.value.resource_group_name
  tags                =  {
        for k, v in each.value.tags:
    k => k == "Name" ? "${each.value.vnet_prefix}-${v}" : v
  }
  lifecycle {
    create_before_destroy = true
  }


  dynamic "subnet" {
    for_each = each.value.subnet
    content {
      name = subnet.value.name
      address_prefixes = subnet.value.address_prefix
    }
  }

}

