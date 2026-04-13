output "route_table_id" {
  description = "The ID of the route table created in the spoke subscription/resource group for routing to the hub firewall."
  value       = azurerm_route_table.spoke_to_hub.id
}

output "peering_id" {
  description = "The ID of the virtual network peering between the spoke and hub virtual networks."
  value       = module.avm_spoke_to_hub_peering.resource_id
}
