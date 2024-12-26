provider "azurerm" {
  features {}
}

# Resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Storage account for Azure Function
resource "azurerm_storage_account" "sa" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# App Service Plan for Azure Function
resource "azurerm_service_plan" "sp" {
  name                = var.service_plan_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

# Azure Function
resource "azurerm_linux_function_app" "function" {
  name                = var.function_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.sp.id
  storage_account_name = azurerm_storage_account.sa.name
  storage_account_access_key = azurerm_storage_account.sa.primary_access_key
  version             = "~4"

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME = "node"
  }
}

# API Management Service
resource "azurerm_api_management" "apim" {
  name                = var.apim_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  publisher_name      = var.apim_publisher_name
  publisher_email     = var.apim_publisher_email
  sku_name            = "Consumption_0"
}

# API Management API
resource "azurerm_api_management_api" "api" {
  name                = var.api_name
  resource_group_name = azurerm_resource_group.rg.name
  api_management_name = azurerm_api_management.apim.name
  revision            = "1"
  display_name        = var.api_display_name
  path                = var.api_path
  protocols           = ["https"]
  service_url         = azurerm_linux_function_app.function.default_hostname
}

# API Management Policy to Restrict Access
resource "azurerm_api_management_api_policy" "policy" {
  api_name                = azurerm_api_management_api.api.name
  api_management_name     = azurerm_api_management.apim.name
  resource_group_name     = azurerm_resource_group.rg.name

  xml_content = <<EOT
<policies>
  <inbound>
    <base />
    <validate-jwt header-name="Authorization" failed-validation-httpcode="401" failed-validation-error-message="Unauthorized" require-scheme="Bearer">
      <open-id-config url="https://login.microsoftonline.com/${var.tenant_id}/v2.0/.well-known/openid-configuration" />
      <required-claims>
        <claim name="aud" match="any">
          <value>${var.aad_client_id}</value>
        </claim>
      </required-claims>
    </validate-jwt>
  </inbound>
  <backend>
    <base />
  </backend>
  <outbound>
    <base />
  </outbound>
</policies>
EOT
}
