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