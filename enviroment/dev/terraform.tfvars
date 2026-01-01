# -------------------------------
# Resource Group
# -------------------------------
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

# -------------------------------
# Virtual Network
# -------------------------------
vnettodo = {
  vnetA = {
    name          = "kaptanvnet45"
    location      = "eastus"
    rg_name       = "rg_todo"
    address_space = ["10.0.0.0/16"]
    tags = {
      environment = "dev"
      owner       = "kaptan"
    }

    subnets = [
      { 
        name             = "frontendsubnet45"
        address_prefixes = ["10.0.1.0/24"]
      },
      { 
        name             = "backendsubnet45"
        address_prefixes = ["10.0.2.0/24"] 
      }
    ]
  }
}

# -------------------------------
# Public IP
# -------------------------------
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

# -------------------------------
# Key Vault
# -------------------------------
kv_todo2 = {
  kv = {
    kv_name                     = "kaptankeyvault45"
    location                    = "eastus"
    rg_name                     = "rg_todo"
    enabled_for_disk_encryption = true
    soft_delete_retention_days  = 7
    purge_protection_enabled    = true
    sku_name                    = "standard"
  }

  network_acls = {
    default_action             = "Deny"
    bypass                     = ["AzureServices"]
    ip_rules                   = ["10.0.1.4"]  # frontendsubnet ka ek IP
    virtual_network_subnet_ids = ["/subscriptions/da14f257-30b3-482a-b2b2-16cc8c996b0a/resourceGroups/rg_todo/providers/Microsoft.Network/virtualNetworks/kaptanvnet45/subnets/frontendsubnet45"]
  }
}

# -------------------------------
# Virtual Machines
# -------------------------------
vm1 = {
  vmA = {
    vm_name                         = "kaptanvm1"
    rg_name                         = "rg_todo"
    location                        = "eastus"
    vm_size                         = "Standard_B1s"
    admin_username                  = "kaptanadmin"
    disable_password_authentication = true
    subnet_name                      = "frontendsubnet45"
    vnet_name                        = "kaptanvnet45"
    pip_name                         = "frontendpip45"
    nic_name                         = "frontendnic45"

    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"

    # -------------------------------
    # SSH Key and VM Agent Fix
    # -------------------------------
    admin_ssh_key = {
      username   = "kaptanadmin"
      public_key = file("~/.ssh/id_rsa.pub")  # ensure ye file exists locally
    }

    provision_vm_agent = false
  }
}
