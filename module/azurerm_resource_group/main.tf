resource "azurerm_resource_group" "rg1" {
  for_each   = var.rg_todo2
  name       = each.value.rg_name
  location   = each.value.location
  managed_by = each.value.managed_by
  tags       = each.value.tags

}

