output "vnet-output" {
  value = [for x in azurerm_virtual_network.vnet:
  {
    vnet_id = x.id
    subnet  = x.subnet
  }]
}
