## WIP: Moving resources out of env/hub into module/hub
module "spoke_spoke1" {
  source = "../../modules/hub"

  spoke = {
    subscription_id        = var.spokes["spoke1"].subscription_id
    tenant_id              = var.spokes["spoke1"].tenant_id
    environment            = var.spokes["spoke1"].environment
    location               = var.spokes["spoke1"].location
    resource_group_name    = var.spokes["spoke1"].resource_group_name
    subnet_workload_id     = var.spokes["spoke1"].subnet_workload_id
    subnet_private_link_id = var.spokes["spoke1"].subnet_private_link_id
    vnet_id                = var.spokes["spoke1"].vnet_id
  }

  hub_vnet_id = module.virtual_network.resource_id
}
module "spoke_spoke2" {
  source = "../../modules/hub"

  spoke = {
    subscription_id        = var.spokes["spoke2"].subscription_id
    tenant_id              = var.spokes["spoke2"].tenant_id
    environment            = var.spokes["spoke2"].environment
    location               = var.spokes["spoke2"].location
    resource_group_name    = var.spokes["spoke2"].resource_group_name
    subnet_workload_id     = var.spokes["spoke2"].subnet_workload_id
    subnet_private_link_id = var.spokes["spoke2"].subnet_private_link_id
    vnet_id                = var.spokes["spoke2"].vnet_id
  }

  hub_vnet_id = module.virtual_network.resource_id
}
