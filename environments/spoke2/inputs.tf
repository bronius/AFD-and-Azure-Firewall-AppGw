variable "location" {
  type        = string
  description = "The Azure region where resources will be deployed."
  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.location))
    error_message = "The location must only contain lowercase letters, numbers, and hyphens."
  }
  default = "southcentralus"
}

variable "subscription_id" {
  type = string
  description = "Spoke subscription Id"
  default = "19d9f48a-d2a3-4351-a256-9d7ed76f557e" # it-ece-spoke2
}

variable "tenant_id" {
  type = string
  description = "Spoke tenant Id"
  default = "36455724-bf27-40b1-80b1-b1434a7dfe8b" # Texas A&M University (Staging)
}

variable "environment" {
  type = string
  description = "Environment (spoke1, spoke2, hub...)"
  default = "spoke2"
}

# variable "hub_firewall_private_ip_address" {
#   type        = string
#   description = "The private IP address of the hub firewall (From HUB module.firewall.resource.ip_configuration[0].private_ip_address)."
#   validation {
#     condition = can(cidrhost(var.hub_firewall_private_ip_address, 0))
#     error_message = "Must be a valid IP address."
#   }
# }

# ---------------------------------------------------------------------------
# Private Link Options
# ---------------------------------------------------------------------------

variable "enable_appgw_private_link" {
  type = bool
  description = "Dedicate a subnet and private IP for the Application Gateway Private Link frontend."
  default = true
}

# ---------------------------------------------------------------------------
# Spoke VNet
# ---------------------------------------------------------------------------
variable "spoke_address_space" {
  type        = string
  description = "The address space for the spoke virtual network."
  default     = "10.2.0.0/16"
}

variable "spoke_workload_subnet_address_prefix" {
  type        = string
  description = "The address prefix for the workload subnet in the spoke VNet."
  default     = "10.2.1.0/24"
}

variable "spoke_appgw_subnet_address_prefix" {
  type        = string
  description = "The address prefix for the Application Gateway subnet in the spoke VNet. Minimum /26 required."
  default     = "10.2.2.0/24"
}

variable "appgw_private_link_subnet_prefix" {
  type        = string
  description = "Address prefix for the dedicated Private Link service subnet in the spoke VNet. Minimum /29. Only used when enable_appgw_private_link = true."
  default     = "10.2.3.0/29"
  validation {
    condition     = can(cidrhost(var.appgw_private_link_subnet_prefix, 0))
    error_message = "Must be a valid CIDR prefix (e.g. 10.1.3.0/29)."
  }
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources."
  default = {
    Environment = "Spoke2" # Variable not allowed
    ManagedBy   = "Terraform"
    Purpose     = "AzureFirewall"
  }
}
