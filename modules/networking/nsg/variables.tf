variable "config" {
  type = object({
    security-groups = list(object({
      name                = string
      resource_group_name = string
      location            = string
      sg_prefix           = string
      tags                = map(string)
      rules = list(object({
        access                     = string
        destination_address_prefix = string
        destination_port_ranges    = list(string)
        direction                  = string
        name                       = string
        priority                   = string
        protocol                   = string
        source_address_prefixes    = list(string)
        source_port_range          = string
      }))


    }))
  })
}