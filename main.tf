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
    # Prevent accidental destroy of App Configuration store.
    prevent_destroy = var.prevent_destroy
  }
}
