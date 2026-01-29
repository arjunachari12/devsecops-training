terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# ISSUE 1: Storage account with public access enabled (CKV_AZURE_35, CKV_AZURE_36)
# ISSUE 2: HTTPS not enforced (CKV_AZURE_2)
resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  
  # ISSUE: Public access enabled
  public_network_access_enabled = true
  
  # ISSUE: HTTPS not enforced
  https_traffic_only_enabled = false
  
  # ISSUE: No encryption at rest
  infrastructure_encryption_enabled = false
}

resource "azurerm_storage_account_network_rules" "storage_rules" {
  storage_account_id = azurerm_storage_account.storage.id
  
  # ISSUE: Default action allows all
  default_action             = "Allow"
  bypass                     = ["AzureServices"]
  virtual_network_subnet_ids = []
  ip_rules                   = []
}

# ISSUE: Blob storage container with public access (CKV_AZURE_34)
resource "azurerm_storage_container" "container" {
  name                  = "data"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "blob"  # Public access - ISSUE!
}

output "storage_account_id" {
  value       = azurerm_storage_account.storage.id
  description = "Storage Account ID"
}
