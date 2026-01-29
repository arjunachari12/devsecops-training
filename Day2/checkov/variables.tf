variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
  default     = "rg-exercise"
}

variable "location" {
  type        = string
  description = "Azure region for resources"
  default     = "eastus"
}

variable "storage_account_name" {
  type        = string
  description = "Name of the storage account (must be globally unique)"
  default     = "storageexercise123"
}
