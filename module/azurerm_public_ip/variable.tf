variable "pip_todo" {
    description = "public ip create"
    type = map(object({
        pip_name              = string
        rg_name          = string
        location         = string
        allocation_method = string
        tags             = optional(map(string))
    }))
  
}
