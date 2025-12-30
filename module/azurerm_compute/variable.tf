
  variable "vms" {
  type = map(object({
    rg_name        = string
    location       = string
    vm_name        = string
    vm_size        = string
    admin_username = string
    admin_password = string
    disable_password_authentication = bool
    subnet_name = string
    vnet_name = string
    pip_name = string
    nic_name = string

    publisher = string
    offer     = string
    sku       = string
    version   = string
  }))
}
