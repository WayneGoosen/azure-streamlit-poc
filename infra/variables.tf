variable "resource_group_name" {
  description = "Name of the Azure resource group where resources will be deployed"
  type        = string
  default     = "rg-streamlit-poc"
}

variable "docker_image_name" {
  description = "Docker image name and tag to deploy (format: repository/image:tag). Combined with docker_registry_url to form the fully-qualified image."
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
  description = "Flag to indicate if Docker registry authentication is required (set to true for private registries)"
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
  description = "Additional environment variables to inject into the container (merged with default settings)"
  type        = map(string)
  default     = {}
}

variable "container_cpu" {
  description = "CPU cores allocated to the container. Allowed values are increments of 0.25 from 0.25 to 4.0."
  type        = number
  default     = 0.5
  validation {
    condition     = contains([0.25, 0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0, 2.25, 2.5, 2.75, 3.0, 3.25, 3.5, 3.75, 4.0], var.container_cpu)
    error_message = "container_cpu must be one of: 0.25, 0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0, 2.25, 2.5, 2.75, 3.0, 3.25, 3.5, 3.75, 4.0."
  }
}

variable "container_memory" {
  description = "Memory allocated to the container. Must be paired with a compatible cpu value (memory:cpu ratio of 2:1 GiB:vCPU)."
  type        = string
  default     = "1Gi"
  validation {
    condition     = can(regex("^(0\\.5|1|1\\.5|2|2\\.5|3|3\\.5|4|4\\.5|5|5\\.5|6|6\\.5|7|7\\.5|8)Gi$", var.container_memory))
    error_message = "container_memory must be in the format 'NGi' between 0.5Gi and 8Gi in 0.5Gi increments."
  }
}

variable "min_replicas" {
  description = "Minimum number of replicas. Set to 0 to enable scale-to-zero (pay only when receiving traffic)."
  type        = number
  default     = 0
  validation {
    condition     = var.min_replicas >= 0 && var.min_replicas <= 25
    error_message = "min_replicas must be between 0 and 25."
  }
}

variable "max_replicas" {
  description = "Maximum number of replicas. Streamlit holds session state in-memory; sticky sessions are enabled to keep users on the same replica."
  type        = number
  default     = 1
  validation {
    condition     = var.max_replicas >= 1 && var.max_replicas <= 25
    error_message = "max_replicas must be between 1 and 25."
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
