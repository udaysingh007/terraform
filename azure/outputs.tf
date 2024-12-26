output "function_url" {
  description = "URL of the Azure Function"
  value       = azurerm_linux_function_app.function.default_hostname
}

output "apim_gateway_url" {
  description = "API Management Gateway URL"
  value       = azurerm_api_management.apim.gateway_url
}
