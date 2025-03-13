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

output "configuration_keys" {
  description = "The keys added to the App Configuration store."
  value = {
    noun_value      = azurerm_app_configuration_key.noun_value.key
    adjective_value = azurerm_app_configuration_key.adjective_value.key
    config_json     = azurerm_app_configuration_key.configuration_json.key
  }
}
