## Peering in perspective of spok to hub. If implemented from hub side, the peering parent and remote parameters should be reversed and other properties considered.

module "avm_spoke_to_hub_peering" {
  source = "Azure/avm-res-network-virtualnetwork/azurerm//modules/peering"

  parent_id = var.spoke.vnet_id

  remote_virtual_network_id = var.hub_vnet_id

  name                                 = "peer-spoke-to-hub"
  allow_forwarded_traffic              = true
  allow_virtual_network_access         = true
  allow_gateway_transit                = false
  use_remote_gateways                  = false
  create_reverse_peering               = true
  reverse_name                         = "peer-hub-to-${var.spoke.environment}"
  reverse_allow_forwarded_traffic      = true
  reverse_allow_gateway_transit        = true
  reverse_allow_virtual_network_access = true
  reverse_use_remote_gateways          = false
}
