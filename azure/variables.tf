variable "location" {
  description = "Azure location"
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "storage_account_name" {
  description = "Storage account name"
  type        = string
}

variable "service_plan_name" {
  description = "App Service Plan name"
  type        = string
}

variable "function_name" {
  description = "Azure Function name"
  type        = string
}

variable "apim_name" {
  description = "API Management service name"
  type        = string
}

variable "apim_publisher_name" {
  description = "Publisher name for API Management"
  type        = string
}

variable "apim_publisher_email" {
  description = "Publisher email for API Management"
  type        = string
}

variable "api_name" {
  description = "API name in API Management"
  type        = string
}

variable "api_display_name" {
  description = "Display name for the API"
  type        = string
}

variable "api_path" {
  description = "Path for the API"
  type        = string
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}

variable "aad_client_id" {
  description = "Client ID to validate in the JWT"
  type        = string
}
