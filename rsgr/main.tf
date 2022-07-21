resource "azurerm_resource_group" "rsgr" {
  name     = "devopsfabio"
  location = "eastus2"
    tags = {
      ambiente = "dev"
      palanca = "alta"
    }
}

output "rsgr_name" {
  value = azurerm_resource_group.rsgr.name
}