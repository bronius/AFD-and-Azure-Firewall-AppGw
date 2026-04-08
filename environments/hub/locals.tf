# Calculate resource names
locals {
  name_replacements = {
    workload       = var.resource_name_workload
    environment    = var.resource_name_environment
    location       = var.location
    location_short = var.resource_name_location_short == "" ? module.regions.regions_by_name[var.location].geo_code : var.resource_name_location_short
    uniqueness     = random_string.unique_name.id
    sequence       = format("%03d", var.resource_name_sequence_start)
  }

  resource_names = { for key, value in var.resource_name_templates : key => templatestring(value, local.name_replacements) }
}

# Diagnostic settings
locals {
  diagnostic_settings = {
    send_to_log_analytics = {
      name                           = "send-to-law"
      workspace_resource_id          = module.log_analytics_workspace.resource_id
      log_analytics_destination_type = "Dedicated"
    }
  }
}

locals {
  tenant_id       = "36455724-bf27-40b1-80b1-b1434a7dfe8b" # Texas A&M University (Staging)
  subscription_id = "3b1b9773-e995-4f5e-b43c-e0102635ffd7" # it-ece-hub
}
