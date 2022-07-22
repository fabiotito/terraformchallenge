resource "azurerm_service_plan" "aspl" {
  name                = local.aspl_name
  resource_group_name = var.rsgr_name
  location            = local.location
  sku_name            = "S1"
  os_type             = "Windows"
}

resource "azurerm_windows_web_app" "wapp" {
  name                = local.wapp_name
  resource_group_name = var.rsgr_name
  location            = local.location
  service_plan_id     = azurerm_service_plan.aspl.id

  site_config {}
}

resource "azurerm_windows_web_app_slot" "example" {
  name           = "app-release"
  app_service_id = azurerm_windows_web_app.wapp.id

  site_config {}
}

#webtest

resource "azurerm_application_insights" "apin" {
  name                = local.apin_name
  location            = local.location
  resource_group_name = var.rsgr_name
  workspace_id        = var.lgan_id
  application_type    = "web"
}
  
resource "azurerm_application_insights_web_test" "webtest" {
  name                    = local.webtest_name
  location                = local.location
  resource_group_name     = azurerm_application_insights.apin.resource_group_name
  application_insights_id = azurerm_application_insights.apin.id
  kind                    = "ping"
  frequency               = 300
  timeout                 = 60
  enabled                 = true
  geo_locations           = ["us-tx-sn1-azr", "us-il-ch1-azr"]

  configuration = <<XML
<WebTest Name="WebTest1" Id="ABD48585-0831-40CB-9069-682EA6BB3583" Enabled="True" CssProjectStructure="" CssIteration="" Timeout="0" WorkItemIds="" xmlns="http://microsoft.com/schemas/VisualStudio/TeamTest/2010" Description="" CredentialUserName="" CredentialPassword="" PreAuthenticate="True" Proxy="default" StopOnError="False" RecordedResultFile="" ResultsLocale="">
  <Items>
    <Request Method="GET" Guid="a5f10126-e4cd-570d-961c-cea43999a200" Version="1.1" Url="https://${azurerm_windows_web_app.wapp.default_hostname}" ThinkTime="0" Timeout="300" ParseDependentRequests="True" FollowRedirects="True" RecordResult="True" Cache="False" ResponseTimeGoal="0" Encoding="utf-8" ExpectedHttpStatusCode="200" ExpectedResponseUrl="" ReportingName="" IgnoreHttpStatusCode="False" />
  </Items>
</WebTest>
XML
    
  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}  
  

resource "azurerm_monitor_action_group" "actiongroup" {
  name                = "actiongroup-devopsteam"
  resource_group_name = azurerm_application_insights_web_test.webtest.resource_group_name
  short_name          = "DevopsTeams"

  email_receiver {
    name          = "Senddevopsteam"
    email_address = "fabiotito1@outlook.com"
  }
}

resource "azurerm_monitor_metric_alert" "azal" {
  name                = local.azal_name
  resource_group_name = azurerm_application_insights_web_test.webtest.resource_group_name
  scopes              = [azurerm_application_insights_web_test.webtest.id, azurerm_application_insights.apin.id]
  description         = "Action will be triggered when Static Web App is down"
    
  application_insights_web_test_location_availability_criteria {
    web_test_id           = azurerm_application_insights_web_test.webtest.id
    component_id          = azurerm_application_insights.apin.id
    failed_location_count = "2"
  }
    
  action {
    action_group_id = azurerm_monitor_action_group.actiongroup.id
  }
}  
