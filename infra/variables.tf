variable "resource_group_name" {
  description = "Name of the Azure resource group where resources will be deployed"
  type        = string
  default     = "rg-streamlit-poc"
}

variable "docker_image_name" {
  description = "Docker image name and tag to deploy (format: repository/image:tag)"
  type        = string
  default     = "waynegoosen/azure-streamlit-poc:0.1.1"
  validation {
    condition     = can(regex("^[^:]+:[^:]+$", var.docker_image_name)) || can(regex("^[^:]+$", var.docker_image_name))
    error_message = "Docker image name should be in format 'repository/image:tag' or 'repository/image'."
  }
}

variable "docker_registry_url" {
  description = "URL of the Docker registry (e.g., https://ghcr.io, https://docker.io)"
  type        = string
  default     = "https://ghcr.io"
  validation {
    condition     = can(regex("^https?://", var.docker_registry_url))
    error_message = "Docker registry URL must start with http:// or https://."
  }
}

variable "use_docker_registry_auth" {
  description = "Flag to indicate if Docker registry authentication is required"
  type        = bool
  default     = false
}

variable "docker_registry_username" {
  description = "Docker registry username for authentication"
  type        = string
  default     = ""
  sensitive   = true
}

variable "docker_registry_password" {
  description = "Docker registry password"
  type        = string
  default     = ""
  sensitive   = true
}

variable "app_settings" {
  description = "Additional application settings to merge with default settings"
  type        = map(string)
  default     = {}
}

variable "always_on_enabled" {
  description = "Enable always_on feature. Note: Cannot be true when using Free, F1, or D1 SKUs."
  type        = bool
  default     = true
}

variable "app_service_plan_sku_name" {
  description = "SKU name for the App Service Plan. IMPORTANT: Free, F1, and D1 SKUs do not support always_on feature. If using these SKUs, set always_on_enabled to false."
  type        = string
  default     = "B1"
  validation {
    condition     = contains(["B1", "B2", "B3", "D1", "F1", "P1v2", "P2v2", "P3v2", "P0v3", "P1v3", "P2v3", "P3v3", "P1mv3", "P2mv3", "P3mv3", "P4mv3", "P5mv3"], var.app_service_plan_sku_name)
    error_message = "The app_service_plan_sku_name must be one of the following: B1, B2, B3, D1, F1, P1v2, P2v2, P3v2, P0v3, P1v3, P2v3, P3v3, P1mv3, P2mv3, P3mv3, P4mv3, P5mv3."
  }
}

variable "app_name" {
  description = "Name of the application used for resource naming"
  type        = string
  default     = "azure-streamlit-poc"
  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.app_name))
    error_message = "App name must contain only lowercase letters, numbers, and hyphens."
  }
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}