module "log_analytics" {
  source = "github.com/equinor/terraform-azurerm-log-analytics?ref=v1.5.0"

  workspace_name      = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "app_config" {
  source = "github.com/equinor/terraform-azurerm-app-config"

  store_name                 = var.name
  resource_group_name        = var.resource_group_name
  location                   = var.location
  sku                        = "free"
  log_analytics_workspace_id = module.log_analytics.workspace_id
}
