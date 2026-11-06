resource "azurerm_virtual_network" "sandbox" {
  name                = "vnet-terraform-sandbox-demo"
  address_space       = ["10.240.0.0/16"]
  location            = "eastus"
  resource_group_name = "rg-terraform-sandbox"

  tags = {
    environment = "sandbox"
    managed_by  = "terraform"
    purpose     = "github-actions-oidc-test"
  }
}
