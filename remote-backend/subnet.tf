resource "azurerm_subnet" "default" {
  name = "default"
  resource_group_name = azurerm_resource_group.kuber.name
  virtual_network_name = azurerm_virtual_network.remote-vnet.name
  address_prefixes = ["192.168.0.0/25"]
}