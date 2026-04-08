terraform {
  required_version = "~> 1.10"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.19"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
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
  subscription_id = local.subscription_id
  tenant_id       = local.tenant_id
}

provider "azurerm" {
  alias = "spoke"
  subscription_id = var.spokes["spoke1"].subscription_id
  tenant_id       = var.spokes["spoke1"].tenant_id

  features {}  
  resource_provider_registrations = "none"
}

provider "modtm" {
  enabled = false
}

## TODO: Peering provided by HUB side.

# resource "azurerm_resource_group" "vnet" {
#   for_each = var.spokes
#   name     = each.value.resource_group_name
#   location = var.location

#   tags = var.tags
# }

resource "random_string" "unique_name" {
  length  = 3
  special = false
  upper   = false
  numeric = false
}

module "resource_group" {
  source   = "Azure/avm-res-resources-resourcegroup/azurerm"
  version  = "0.2.1"
  location = var.location
  name     = local.resource_names.resource_group_name
  enable_telemetry    = false
  tags     = var.tags
}

moved {
  from = azurerm_resource_group.vnet
  to = module.spoke_spoke1.azurerm_resource_group.vnet
}

moved {
  from = azurerm_route.spoke_to_hub
  to = module.spoke_spoke1.azurerm_route.spoke_to_hub
}

moved {
  from = azurerm_route_table.spoke_to_hub
  to = module.spoke_spoke1.azurerm_route_table.spoke_to_hub
}

moved {
  from = azurerm_subnet_route_table_association.spoke_to_hub
  to = module.spoke_spoke1.azurerm_subnet_route_table_association.spoke_to_hub
}

moved {
  from = module.avm_spoke_to_hub_peering
  to = module.spoke_spoke1.module.avm_spoke_to_hub_peering
}