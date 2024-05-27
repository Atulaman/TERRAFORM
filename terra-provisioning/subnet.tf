#creating subnet
resource "azurerm_subnet" "default" {
  name                 = "default"
  resource_group_name  = azurerm_resource_group.kuber.name
  virtual_network_name = azurerm_virtual_network.terra-VNeT.name
  address_prefixes     = ["192.168.1.0/25"]

}