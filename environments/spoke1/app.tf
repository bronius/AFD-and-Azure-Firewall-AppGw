resource "azurerm_resource_group" "workload" {
  name     = "rg-${var.environment}"
  location = "southcentralus"
}

resource "azurerm_app_service_plan" "workload" {
  name                = "appserviceplan-${var.environment}"
  resource_group_name = azurerm_resource_group.workload.name
  location            = azurerm_resource_group.workload.location
  kind                = "Linux"
  reserved            = true # required for Linux: not the same as "reserved instances"

  sku {
    tier = "Basic"
    size = "B1"
  }

}

resource "azurerm_linux_web_app" "workload" {
  name                = "webapp-${var.environment}"
  resource_group_name = azurerm_resource_group.workload.name
  location            = azurerm_resource_group.workload.location
  service_plan_id     = azurerm_app_service_plan.workload.id

  public_network_access_enabled = false # force traffic through the hub

  virtual_network_subnet_id = module.spoke_virtual_network.subnets["workload"].resource_id

  site_config {
    vnet_route_all_enabled = true # force all outbound traffic through the vnet (and thus the hub)
    always_on = true # must be false with free plan
    application_stack {
      node_version = "24-lts"
    }
  }

}

resource "azurerm_private_endpoint" "workload" {
  name                = "pvtlink-workload-${var.environment}"
  resource_group_name = azurerm_resource_group.workload.name
  location            = azurerm_resource_group.workload.location
  subnet_id           = module.spoke_virtual_network.subnets["appgw-pvtlink"].resource_id

  custom_network_interface_name = "pvtlink-workload-${var.environment}-nic"

  private_dns_zone_group {
    name = "default"
    private_dns_zone_ids = [
      "/subscriptions/${var.subscription_id}/resourceGroups/${azurerm_resource_group.vnet.name}/providers/Microsoft.Network/privateDnsZones/privatelink.azurewebsites.net"
    ]
  }

  private_service_connection {
    name                           = "pvtlink-workload-${var.environment}"
    is_manual_connection            = false
    private_connection_resource_id   = azurerm_linux_web_app.workload.id
    subresource_names               = ["sites"]
  }
}