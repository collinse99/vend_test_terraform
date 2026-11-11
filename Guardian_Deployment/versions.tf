terraform {
  required_version = ">= 1.6.0, < 1.7.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-terraform-state-sandbox"
    storage_account_name = "erictfstate2026"
    container_name       = "tfstate"
    key                  = "guardian-storage.tfstate"

    # Authenticate to the state backend with the GitHub OIDC identity.
    use_oidc        = true
    use_azuread_auth = true
  }
}

provider "azurerm" {
  resource_provider_registrations = "none"
  features {}
}
