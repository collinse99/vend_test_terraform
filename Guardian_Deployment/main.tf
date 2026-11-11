variable "storage_account_name" {
  type        = string
  description = "Globally unique name for the Guardian storage account."

  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.storage_account_name))
    error_message = "Use 3 to 24 lowercase letters or digits."
  }
}

resource "azurerm_resource_group" "guardian" {
  name     = "rg-guardian-aum-lab"
  location = "eastus"
}

resource "azurerm_storage_account" "guardian" {
  name                            = var.storage_account_name
  resource_group_name             = azurerm_resource_group.guardian.name
  location                        = azurerm_resource_group.guardian.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  account_kind                    = "StorageV2"
  is_hns_enabled                  = true
  allow_nested_items_to_be_public = false
  shared_access_key_enabled       = false
  min_tls_version                 = "TLS1_2"
}

resource "azurerm_storage_container" "aum_bronze" {
  name                  = "aum-bronze"
  storage_account_id    = azurerm_storage_account.guardian.id
  container_access_type = "private"
}

output "storage_account_name" {
  value = azurerm_storage_account.guardian.name
}
