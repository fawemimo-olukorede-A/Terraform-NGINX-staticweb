resource "azurerm_subnet_network_security_group_association" "attach" {
  for_each                  = { for x in var.config.attach-security-groups : x.name => x }
  subnet_id                 = each.value.subnet_id
  network_security_group_id = each.value.network_security_group_id
  lifecycle {
    create_before_destroy = true
  }
}