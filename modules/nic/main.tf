resource "azurerm_network_interface" "nic" {
  for_each = { for x in var.config.nic : x.name => x }
  
  name                =  each.value.name
  location            = coalesce(each.value.location, "UK South")
  resource_group_name = each.value.resource_group_name
  
  ip_configuration {
    name                          = each.value.ip_configuration.ip_config_name
    subnet_id                     = each.value.ip_configuration.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = each.value.ip_configuration.public_ip_address_id
  }
  
  tags = each.value.tags
}

