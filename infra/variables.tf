variable "resource_group_name" {
  type        = string
  default     = "rg-streamlit-poc"
}

variable "docker_image_name" {
  type        = string
  default     = "waynegoosen/azure-streamlit-poc:0.1.1"
}

variable "docker_registry_url" {
  type        = string
  default     = "https://ghcr.io"
}

variable "use_docker_registry_auth" {
  description = "Flag to indicate if Docker registry authentication is required"
  type        = bool
  default     = false
}

variable "docker_registry_username" {
  description = "Docker registry username"
  type        = string
  default     = ""
}

variable "docker_registry_password" {
  description = "Docker registry password"
  type        = string
  default     = ""
  sensitive   = true
}

variable "app_settings" {
  type        = map(string)
  default     = {}
  description = "Application setting"
}

variable "app_service_plan_sku_name" {
  type        = string
  default     = "B1"
  validation {
    condition     = contains(["B1", "B2", "B3", "D1", "F1", "P1v2", "P2v2", "P3v2", "P0v3", "P1v3", "P2v3", "P3v3", "P1mv3", "P2mv3", "P3mv3", "P4mv3", "P5mv3"], var.app_service_plan_sku_name)
    error_message = "The app_service_plan_sku_name must be one of the following: B1, B2, B3, D1, F1, P1v2, P2v2, P3v2, P0v3, P1v3, P2v3, P3v3, P1mv3, P2mv3, P3mv3, P4mv3, P5mv3."
  }
}

variable "app_name" {
  type        = string
  default     = "azure-streamlit-poc"
}

variable "environment" {
  type        = string
  default     = "prod"
}