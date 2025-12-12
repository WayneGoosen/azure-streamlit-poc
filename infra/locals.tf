locals {
  app_service_plan_name = "asp-${var.app_name}"
  linux_web_app_name    = "app-${var.app_name}"
  app_settings = {
    ENV = var.environment
  }
  
  # Common tags for all resources
  common_tags = {
    Environment = var.environment
    Application = var.app_name
    ManagedBy   = "Terraform"
  }
  
  # Log level based on environment
  log_level = var.environment == "prod" ? "Warning" : "Verbose"
  
  # Prevent destroy for production environment
  prevent_destroy = var.environment == "prod"
}