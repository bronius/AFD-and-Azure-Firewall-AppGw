# Creates route table in the spoke subscription/resource group with a route to hub firewall.
# The spoke subnet iac references this resource by ID to ensure traffic is routed through the hub.
resource "azurerm_route_table" "spoke_to_hub" {
  provider = azurerm.spoke

  name                          = "spoke-to-hub"
  location                      = var.spoke.location
  resource_group_name           = var.spoke.resource_group_name
  bgp_route_propagation_enabled = false

  tags = var.hub_tags
}

# Separate resource in case route table already exists and needs to be updated with the new route.
resource "azurerm_route" "spoke_to_hub" {
  provider = azurerm.spoke

  name                   = "route-to-hub-firewall"
  resource_group_name    = azurerm_route_table.spoke_to_hub.resource_group_name
  route_table_name       = azurerm_route_table.spoke_to_hub.name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  # next_hop_in_ip_address = module.firewall.resource.ip_configuration[0].private_ip_address
  next_hop_in_ip_address = "123.123.123.123"
}

resource "azurerm_subnet_route_table_association" "spoke_to_hub" {
  provider = azurerm.spoke

  subnet_id      = var.spoke.subnet_workload_id
  route_table_id = azurerm_route_table.spoke_to_hub.id
}
