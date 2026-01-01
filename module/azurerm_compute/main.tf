resource "azurerm_network_interface" "nic1" {
  for_each            = var.vms
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet[each.value.subnet_name].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id           = try(azurerm_public_ip.pip[each.value.pip_name].id, null)
  }
}

resource "azurerm_linux_virtual_machine" "vm1" {
  for_each = var.vms

  name                = each.value.vm_name
  resource_group_name = each.value.rg_name
  location            = each.value.location
  size                = each.value.vm_size
  admin_username      = each.value.admin_username

  disable_password_authentication = true

  network_interface_ids = [
    azurerm_network_interface.nic1[each.key].id
  ]  

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = each.value.publisher
    offer     = each.value.offer
    sku       = each.value.sku
    version   = each.value.version
  }

  # ✅ Checkov fix: SSH key required
  admin_ssh_key {
    username   = each.value.admin_username
    public_key = file("~/.ssh/id_rsa.pub")  # Ensure this file exists locally
  }

  # ✅ Checkov fix: no VM agent / extensions
  provision_vm_agent = false
}
