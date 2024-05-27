#creating virtual network
resource "azurerm_virtual_network" "terra-VNeT" {
  name                = "terra-VNeT"
  resource_group_name = azurerm_resource_group.kuber.name
  location            = azurerm_resource_group.kuber.location
  address_space       = ["192.168.1.0/24"]
  tags = {
    environment = var.environment
  }
}