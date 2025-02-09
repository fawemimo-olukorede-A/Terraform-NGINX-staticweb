variable "config" {
  type = object({
    vm = list(object({
      name                = string
      resource_group_name = string
      location           = string
      size               = string
      admin_username     = string
      admin_password     = string
      network_interface_ids = list(string)
      source_image_reference = map(string)
      os_disk = map(string)
      tags               = map(string)
    }))
  })
}