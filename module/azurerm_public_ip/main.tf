resource "azurerm_public_ip" "pip" {
    for_each = var.pip_todo
  name                = each.value.pip_name
  resource_group_name = each.value.rg_name
  location            = each.value.location
  allocation_method   = each.value.allocation_method

  tags = each.value.tags
    
  }
