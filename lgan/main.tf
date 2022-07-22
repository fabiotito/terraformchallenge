resource "azurerm_log_analytics_workspace" "lgan" {
  name                = local.lgan_name
  location            = local.location
  resource_group_name = var.rsgr_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}