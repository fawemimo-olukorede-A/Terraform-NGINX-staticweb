variable "config" {
  type = object({
    public-ip = list(object({
      name                = string
      resource_group_name = string
      location            = string
      allocation_method   = string
      sku                 = string
      sku_tier            = string
    }))
  })
}