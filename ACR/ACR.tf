provider "azurerm" {
  features {

  }
}
resource "azurerm_container_registry" "myregistry" {
  name                = "mikku1999"
  resource_group_name = azurerm_resource_group.react.name
  location            = azurerm_resource_group.react.location
  sku                 = "Premium"
  admin_enabled       = true
}
