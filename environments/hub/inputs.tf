variable "spokes" {
  type = map(object({
      subscription_id        = string
      tenant_id              = string
      environment            = string
      location               = string
      resource_group_name    = string
      subnet_workload_id     = string
      subnet_private_link_id = string
      vnet_id                = string
  }))
  description = "List of spoke configurations for hub-spoke connectivity."
}

# variable "spoke_resource_group_name" {
#   type = string
#   description = "The name of the resource group containing the spoke resources."
# }

# variable "spoke_subnet_workload_id" {
#   type = string
#   description = "The resource ID of the spoke workload subnet."
# }

# variable "spoke_subnet_private_link_id" {
#   type = string
#   description = "The resource ID of the spoke private link subnet."
# }

# variable "spoke_subscription_id" {
#   type = string
#   description = "The subscription ID of the spoke resources."
# }

# variable "spoke_tenant_id" {
#   type = string
#   description = "The tenant ID of the spoke resources."
# }

# variable "spoke_vnet_id" {
#   ## TODO: Allow for multiple spoke vnets
#   type        = string
#   description = "The resource ID of the spoke virtual network."
# }
