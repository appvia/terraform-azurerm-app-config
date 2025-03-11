resource "azurerm_resource_group" "this" {
  count    = var.create_resource_group ? 1 : 0
  name     = var.resource_group_name
  location = var.location
}

module "azure_log_analytics_workspace" {
  source = "github.com/equinor/terraform-azurerm-log-analytics?ref=v1.5.0"

  workspace_name      = var.name
  resource_group_name = var.create_resource_group ? azurerm_resource_group.this[0].name : var.resource_group_name
  location            = var.location
}

module "azure_app_configuration" {
  source = "github.com/equinor/terraform-azurerm-app-config"

  store_name                 = var.name
  resource_group_name        = var.create_resource_group ? azurerm_resource_group.this[0].name : var.resource_group_name
  location                   = var.location
  sku                        = "free"
  log_analytics_workspace_id = module.azure_log_analytics_workspace.workspace_id
}
