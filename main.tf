locals {
  # If system_assigned_identity_enabled is true, value is "SystemAssigned".
  # If identity_ids is non-empty, value is "UserAssigned".
  # If system_assigned_identity_enabled is true and identity_ids is non-empty, value is "SystemAssigned, UserAssigned".
  identity_type = join(", ", compact([var.system_assigned_identity_enabled ? "SystemAssigned" : "", length(var.identity_ids) > 0 ? "UserAssigned" : ""]))

  diagnostic_setting_metric_categories = ["AllMetrics"]
}

resource "azurerm_resource_group" "this" {
  count    = var.create_resource_group ? 1 : 0
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_app_configuration" "this" {
  name                       = var.name
  resource_group_name        = var.create_resource_group ? azurerm_resource_group.this[0].name : var.resource_group_name
  location                   = var.location
  sku                        = var.sku
  local_auth_enabled         = var.local_auth_enabled
  soft_delete_retention_days = var.sku == "standard" ? var.soft_delete_retention_days : null
  purge_protection_enabled   = var.purge_protection_enabled
  public_network_access      = var.public_network_access

  tags = var.tags

  dynamic "identity" {
    for_each = local.identity_type != "" ? [0] : []

    content {
      type         = local.identity_type
      identity_ids = var.identity_ids
    }
  }

  lifecycle {
    prevent_destroy = false
  }
}

# Add configuration key-value pairs
resource "azurerm_app_configuration_key" "noun_value" {
  configuration_store_id = azurerm_app_configuration.this.id
  key                    = "noun_value"
  label                  = var.config_label
  value                  = var.noun_value
  content_type           = "application/json"
}

resource "azurerm_app_configuration_key" "adjective_value" {
  configuration_store_id = azurerm_app_configuration.this.id
  key                    = "adjective_value"
  label                  = var.config_label
  value                  = var.adjective_value
  content_type           = "application/json"
}

# Create connection string access keys for the configuration
resource "azurerm_app_configuration_key" "configuration_json" {
  configuration_store_id = azurerm_app_configuration.this.id
  key                    = ".appconfig.featureflag/configuration"
  label                  = var.config_label
  value                  = jsonencode({
    "noun_value": var.noun_value,
    "adjective_value": var.adjective_value
  })
  content_type           = "application/json"
}
