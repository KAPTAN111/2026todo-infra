variable "rg_todo2" {
    description = "resource group create"
    type = map(object({
        rg_name       = string
        location   = string
        managed_by = string
        tags       = map(string)
    }))
  
}