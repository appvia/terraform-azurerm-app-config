output "store_name" {
  description = "The name of this App Configuration store."
  value       = azurerm_app_configuration.this.name
}

output "store_id" {
  description = "The ID of this App Configuration store."
  value       = azurerm_app_configuration.this.id
}

output "endpoint" {
  description = "The endpoint of this App Configuration store."
  value       = azurerm_app_configuration.this.endpoint
}

output "resource_group_name" {
  description = "The ID of the resource group."
  value       = var.resource_group_name
}
