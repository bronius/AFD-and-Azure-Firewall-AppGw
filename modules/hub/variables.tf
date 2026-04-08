variable "spoke" {
  type = object({
    subscription_id        = string
    tenant_id              = string
    environment            = string
    location               = string
    resource_group_name    = string
    subnet_workload_id     = string
    subnet_private_link_id = string
    vnet_id                = string
  })
  description = "Spoke configuration for hub-spoke connectivity."
}

variable "hub_vnet_id" {
  type = string
  description = "The resource ID of the hub virtual network."
}

variable "hub_tags" {
  type        = map(string)
  description = "A map of tags to add to all resources."
  default = {
    Environment = "Sandbox"
    ManagedBy   = "Terraform"
    Purpose     = "AzureFirewall"
    CostCenter  = "IT-Security (This is an interesting tag)"
    Owner       = "NetworkTeam"
  }
}

variable "spoke_tags" {
  type        = map(string)
  description = "A map of tags to add to all resources."
  default = {
    Environment = "Spoke1" # Variable not allowed here.
    ManagedBy   = "Terraform"
    Purpose     = "AzureFirewall"
  }
}
