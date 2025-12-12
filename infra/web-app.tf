resource "azurerm_service_plan" "service_plan" {
  name                = local.app_service_plan_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = var.app_service_plan_sku_name
  
  tags = local.common_tags
  
}

resource "random_id" "random_chars_web_app_name" {
  byte_length = 2
}

resource "azurerm_linux_web_app" "web-app" {
  name                = "${local.linux_web_app_name}-${random_id.random_chars_web_app_name.hex}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.service_plan.id
  app_settings        = merge(local.app_settings, var.app_settings)
  https_only          = true

  identity {
    type = "SystemAssigned"
  }

  site_config {
    always_on           = var.always_on_enabled
    minimum_tls_version = "1.2"
    application_stack {
      docker_image_name        = var.docker_image_name
      docker_registry_url      = var.docker_registry_url
      docker_registry_username = var.use_docker_registry_auth ? var.docker_registry_username : null
      docker_registry_password = var.use_docker_registry_auth ? var.docker_registry_password : null
    }
  }

  logs {
    application_logs {
      file_system_level = local.log_level
    }
  }

  tags = local.common_tags

}