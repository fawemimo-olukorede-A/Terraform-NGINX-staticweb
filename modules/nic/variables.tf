variable "config" {
  type = object({
    nic = list(object({
      name                = string
      resource_group_name = string
      location           = string
      ip_configuration = map(string)
      tags               = map(string)
    }))
  })
}