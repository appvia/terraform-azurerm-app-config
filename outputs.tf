output "store_name" {
  description = "The name of this App Configuration store."
  value       = module.app_config.store_name
}

output "store_id" {
  description = "The ID of this App Configuration store."
  value       = module.app_config.store_id
}

output "endpoint" {
  description = "The endpoint of this App Configuration store."
  value       = module.app_config.endpoint
}
