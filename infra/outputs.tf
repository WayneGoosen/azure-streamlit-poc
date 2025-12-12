output "web_app_name" {
  description = "Name of the Linux Web App"
  value       = azurerm_linux_web_app.web-app.name
}

output "web_app_url" {
  description = "Default URL of the Linux Web App"
  value       = "https://${azurerm_linux_web_app.web-app.default_hostname}"
}

output "web_app_default_hostname" {
  description = "Default hostname of the Linux Web App"
  value       = azurerm_linux_web_app.web-app.default_hostname
}

output "web_app_id" {
  description = "ID of the Linux Web App"
  value       = azurerm_linux_web_app.web-app.id
}

output "service_plan_id" {
  description = "ID of the App Service Plan"
  value       = azurerm_service_plan.service_plan.id
}

output "service_plan_name" {
  description = "Name of the App Service Plan"
  value       = azurerm_service_plan.service_plan.name
}

output "managed_identity_principal_id" {
  description = "Principal ID of the managed identity assigned to the web app"
  value       = azurerm_linux_web_app.web-app.identity[0].principal_id
  sensitive   = false
}

output "managed_identity_tenant_id" {
  description = "Tenant ID of the managed identity assigned to the web app"
  value       = azurerm_linux_web_app.web-app.identity[0].tenant_id
  sensitive   = false
}

