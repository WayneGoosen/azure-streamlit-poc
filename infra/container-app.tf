resource "azurerm_log_analytics_workspace" "law" {
  name                = local.log_analytics_workspace_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = local.common_tags
}

resource "azurerm_container_app_environment" "env" {
  name                       = local.container_app_environment_name
  location                   = data.azurerm_resource_group.rg.location
  resource_group_name        = data.azurerm_resource_group.rg.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id

  tags = local.common_tags
}

resource "random_id" "random_chars_container_app_name" {
  byte_length = 2
}

resource "azurerm_container_app" "app" {
  name                         = "${local.container_app_name}-${random_id.random_chars_container_app_name.hex}"
  container_app_environment_id = azurerm_container_app_environment.env.id
  resource_group_name          = data.azurerm_resource_group.rg.name
  revision_mode                = "Single"

  identity {
    type = "SystemAssigned"
  }

  template {
    min_replicas = var.min_replicas
    max_replicas = var.max_replicas

    container {
      name   = "streamlit"
      image  = local.full_image
      cpu    = var.container_cpu
      memory = var.container_memory

      dynamic "env" {
        for_each = local.container_env
        content {
          name  = env.key
          value = env.value
        }
      }
    }
  }

  ingress {
    external_enabled = true
    target_port      = 80
    transport        = "auto"

    sticky_sessions {
      affinity = "sticky"
    }

    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }

  dynamic "registry" {
    for_each = var.use_docker_registry_auth ? [1] : []
    content {
      server               = local.registry_host
      username             = var.docker_registry_username
      password_secret_name = "registry-password"
    }
  }

  dynamic "secret" {
    for_each = var.use_docker_registry_auth ? [1] : []
    content {
      name  = "registry-password"
      value = var.docker_registry_password
    }
  }

  tags = local.common_tags
}
