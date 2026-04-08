terraform {
  required_version = "~> 1.10"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.19"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "~> 2.5"
    }
    modtm = {
      source  = "azure/modtm"
      version = "~> 0.3" # Match the version used by your AVMs
    }
  }
}

provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id  
}

resource "azurerm_resource_group" "vnet" {
  name     = "spoke1-rg-vnet"
  location = var.location

  tags = var.tags
}
