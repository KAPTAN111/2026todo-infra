
module "resource_group" {
  source   = "../../module/azurerm_resource_group"
  rg_todo2 = var.rg_todo2
}
module "networking" {
  depends_on = [module.resource_group]
  source     = "../../module/azurerm_netwrking"
  vnettodo   = var.vnettodo
}
module "public_ip" {
  depends_on = [module.resource_group]
  source     = "../../module/azurerm_public_ip"
  pip_todo   = var.pip_todo2
}
module "key_vault" {
  depends_on = [module.resource_group]
  source     = "../../module/azurerm_keyvault"
  kv_todo    = var.kv_todo2
}
module "compute" {
  depends_on = [module.resource_group, module.public_ip, module.key_vault]
  source     = "../../module/azurerm_compute"
  vms        = var.vm1
}