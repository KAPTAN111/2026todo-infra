variable "vnettodo" {
  type = map(object({
    name          = string
    location      = string
    rg_name       = string
    address_space = list(string)
    # dns_servers   = list(string)
    tags          = map(string)
    subnets = optional(list(object({
      name             = string
      address_prefixes = list(string)
    })))
  }))
}

