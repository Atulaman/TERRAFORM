resource "azurerm_virtual_network" "remote-vnet" {
    name = "remote-vnet"
    resource_group_name = azurerm_resource_group.kuber.name
    location = azurerm_resource_group.kuber.location
    address_space = ["192.168.0.0/24"]
}