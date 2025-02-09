variable "config" {
  type = object({
    attach-security-groups = list(object({
      name                      = string
      subnet_id                 = string
      network_security_group_id = string

    }))
  })
}