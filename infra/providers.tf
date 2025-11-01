terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.51.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-streamlit-poc"
    storage_account_name = "streamlittfstate"
    container_name       = "tfstate"
    key                  = "strealitpoctfstate.tfstate"
  }

  required_version = ">= 1.8.0"
}

provider "azurerm" {
  features {}
}