resource "azurerm_network_security_group" "security_groups" {
  for_each            = { for x in var.config.security-groups : x.name => x }
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  lifecycle {
    create_before_destroy = true
  }



  dynamic "security_rule" {
    for_each = each.value.rules
    content {
      name                       = security_rule.value.name
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      priority                   = security_rule.value.priority
      protocol                   = security_rule.value.protocol
      destination_address_prefix = security_rule.value.destination_address_prefix
      destination_port_ranges    = security_rule.value.destination_port_ranges
      source_address_prefixes    = security_rule.value.source_address_prefixes != "" ? security_rule.value.source_address_prefixes : []
      source_port_range          = security_rule.value.source_port_range
    }
  }
  tags = {
    for k, v in each.value.tags :
    k => k == "Name" ? "${each.value.sg_prefix}-${v}" : v
  }
}