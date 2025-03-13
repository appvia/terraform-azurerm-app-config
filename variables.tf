variable "create_resource_group" {
  description = "Flag to determine if a new resource group should be created."
  type        = bool
  default     = false
}

variable "name" {
  description = "The name of the app config resource"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group to create the resources in."
  type        = string
}

variable "location" {
  description = "The location to create the resources in."
  type        = string
}

variable "sku" {
  description = "The SKU of this App Configuration store. Value must be \"free\" or \"standard\"."
  type        = string
  default     = "standard"
  nullable    = false

  validation {
    condition     = contains(["free", "standard"], var.sku)
    error_message = "Sku must be \"free\" or \"standard\"."
  }
}

variable "local_auth_enabled" {
  description = "Is local authentication using access keys enabled for this App Configuration store?"
  type        = bool
  default     = false
  nullable    = false
}

variable "soft_delete_retention_days" {
  description = "The number of days that items should be retained for once soft-deleted. Value must be between 1 and 7."
  type        = number
  default     = 7
  nullable    = false

  validation {
    condition     = var.soft_delete_retention_days >= 1 && var.soft_delete_retention_days <= 7
    error_message = "The soft delete retention days must be between 1 and 7."
  }
}

variable "purge_protection_enabled" {
  description = "Is purge protection enabled for this App Configuration store?"
  type        = bool
  default     = false
  nullable    = false
}

variable "system_assigned_identity_enabled" {
  description = "Should the system-assigned identity be enabled for this App Configuration store?"
  type        = bool
  default     = false
  nullable    = false
}

variable "identity_ids" {
  description = "A list of IDs of managed identities to be assigned to this App Configuration store."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "public_network_access" {
  description = "The public network access setting for this App Configuration store. Value must be \"Enabled\" or \"Disabled\"."
  type        = string
  default     = "Disabled"
  nullable    = false

  validation {
    condition     = contains(["Enabled", "Disabled"], var.public_network_access)
    error_message = "Public network access must be \"Enabled\" or \"Disabled\"."
  }
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
  nullable    = false
}

# New variables for configuration values
variable "noun_value" {
  description = "The noun value to store in the App Configuration"
  type        = string
  default     = "Wayfinder"
  nullable    = false
}

variable "adjective_value" {
  description = "The adjective value to store in the App Configuration"
  type        = string
  default     = "Awesome"
  nullable    = false
}

variable "config_label" {
  description = "The label to use for the configuration values"
  type        = string
  default     = "production"
  nullable    = false
}

variable "use_resource_group_in_name" {
  description = "Flag to determine if the resource group name should be included in the App Configuration name for uniqueness"
  type        = bool
  default     = true
  nullable    = false
}
