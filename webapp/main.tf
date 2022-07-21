resource "azurerm_service_plan" "aspl" {
  name                = local.aspl_name
  resource_group_name = local.rsgr_name
  location            = local.location
  sku_name            = "S1"
  os_type             = "Windows"
}

resource "azurerm_windows_web_app" "wapp" {
  name                = local.wapp_code
  resource_group_name = local.rsgr_name
  location            = local.location
  service_plan_id     = azurerm_service_plan.aspl.id

  site_config {}
}

resource "azurerm_windows_web_app_slot" "example" {
  name           = "app-release"
  app_service_id = azurerm_windows_web_app.wapp.id

  site_config {}
}