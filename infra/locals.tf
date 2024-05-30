locals {
  app_service_plan_name = "asp-${var.app_name}"
  linux_web_app_name = "app-${var.app_name}"  
  app_settings = {
    ENV = var.environment
  }
}