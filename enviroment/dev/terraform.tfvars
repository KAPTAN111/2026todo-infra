rg_todo2 = {
  rg1 = {
    rg_name    = "rg_todo"
    location   = "eastus"
    managed_by = "kaptan"
    tags = {
      env   = "dev"
      owner = "kaptan"
    }
  }

}
vnettodo = {
  vnetA = {
    name          = "kaptanvnet45"
    location      = "eastus"
    rg_name       = "rg_todo"
    address_space = ["10.0.0.0/16"]
    # dns_servers   = ["10.0.0.0/24"]
    tags = {
      environment = "dev"
      owner       = "kaptan"
    }

    subnets = [
      { name             = "frontendsubnet45"
        address_prefixes = ["10.0.1.0/24"]
      },
      { name = "backendsubnet45"
      address_prefixes = ["10.0.2.0/24"] }
    ]
  }
}
pip_todo2 = {
  pip1 = {
    pip_name          = "frontendpip45"
    rg_name           = "rg_todo"
    location          = "eastus"
    allocation_method = "Static"
    tags = {
      environment = "dev"
      owner       = "kaptan"
    }
  }

  pip2 = {
    pip_name          = "backendpip45"
    rg_name           = "rg_todo"
    location          = "eastus"
    allocation_method = "Static"
    tags = {
      environment = "dev"
      owner       = "kaptan"
    }
  }
}
kv_todo2 = {
  kv = {
    kv_name                     = "kaptankeyvault45"
    location                    = "eastus"
    rg_name                     = "rg_todo"
    enabled_for_disk_encryption = true
    soft_delete_retention_days  = 7
    purge_protection_enabled    = false
    sku_name                    = "standard"
  }
  network_acls = {
    default_action             = "Deny"
    bypass                     = "AzureServices"
    ip_rules                   = ["10.0.3.4"]
    virtual_network_subnet_ids = ["/subscriptions/da14f257-30b3-482a-b2b2-16cc8c996b0a/resourceGroups/rg_todo/providers/Microsoft.Network/virtualNetworks/kaptanvnet45/subnets/frontendsubnet45"]
  }
}


vm1 = {
  vmA = {
    vm_name                         = "kaptanvm1"
    rg_name                         = "rg_todo"
    location                        = "eastus"
    vm_size                         = "Standard_B1s"
    admin_username                  = "kaptanadmin"
    admin_password                  = "Kaptan@12345"
    disable_password_authentication = false

    subnet_name = "frontendsubnet45"
    vnet_name   = "kaptanvnet45"
    pip_name    = "frontendpip45"
    nic_name    = "frontendnic45"



    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"

  }
  #   vmB = {
  #     vm_name                         = "kaptanvm2"
  #     rg_name                         = "rg_001A"
  #     location                        = "eastus"
  #     vm_size                         = "Standard_B1s"
  #     admin_username                  = "kaptanadmin"
  #     admin_password                  = "Kaptan@12345"
  #     disable_password_authentication = false

  #     subnet_name = "backendsubnet45"
  #     vnet_name   = "kaptanvnet45"
  #     pip_name    = "backendpip45"
  #     nic_name    = "frontendnic45"



  #     publisher = "Canonical"
  #     offer     = "0001-com-ubuntu-server-jammy"
  #     sku       = "22_04-lts"
  #     version   = "latest"

  #   }
  # }
}
