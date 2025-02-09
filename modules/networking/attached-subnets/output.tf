output "attach-sec-groups-output" {
  value = [for x in azurerm_subnet_network_security_group_association.attach : x.subnet_id]
}
