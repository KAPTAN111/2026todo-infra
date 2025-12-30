terraform {
  backend "azurerm" {
    resource_group_name  = "rg-test1"
    storage_account_name = "infrastoragekaptan1"
    container_name       = "todocontainer"
    key                  = "terraform.tfstate"
  }
}