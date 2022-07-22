resource "azurerm_resource_group" "rsgr" {
  name     = local.rsgr_name
  location = local.location
    tags = {
      enviroment = lower(var.env)
      app_name = var.app_name
    }
}