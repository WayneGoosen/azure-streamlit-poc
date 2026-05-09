output "container_app_name" {
  description = "Name of the Container App"
  value       = azurerm_container_app.app.name
}

output "container_app_url" {
  description = "Public URL of the Container App"
  value       = "https://${azurerm_container_app.app.ingress[0].fqdn}"
}

output "container_app_fqdn" {
  description = "Fully-qualified domain name of the Container App"
  value       = azurerm_container_app.app.ingress[0].fqdn
}

output "container_app_id" {
  description = "ID of the Container App"
  value       = azurerm_container_app.app.id
}

output "container_app_environment_id" {
  description = "ID of the Container App Environment"
  value       = azurerm_container_app_environment.env.id
}

output "container_app_environment_name" {
  description = "Name of the Container App Environment"
  value       = azurerm_container_app_environment.env.name
}

output "log_analytics_workspace_id" {
  description = "ID of the Log Analytics workspace backing the Container App Environment"
  value       = azurerm_log_analytics_workspace.law.id
}

output "managed_identity_principal_id" {
  description = "Principal ID of the managed identity assigned to the container app"
  value       = azurerm_container_app.app.identity[0].principal_id
  sensitive   = false
}

output "managed_identity_tenant_id" {
  description = "Tenant ID of the managed identity assigned to the container app"
  value       = azurerm_container_app.app.identity[0].tenant_id
  sensitive   = false
}
