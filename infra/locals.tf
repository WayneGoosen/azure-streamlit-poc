locals {
  log_analytics_workspace_name   = "log-${var.app_name}"
  container_app_environment_name = "cae-${var.app_name}"
  container_app_name             = "ca-${var.app_name}"

  registry_host = replace(replace(var.docker_registry_url, "https://", ""), "http://", "")
  full_image    = "${local.registry_host}/${var.docker_image_name}"

  container_env = merge({
    ENV = var.environment
  }, var.app_settings)

  common_tags = {
    Environment = var.environment
    Application = var.app_name
    ManagedBy   = "Terraform"
  }
}
