#apply NSG to VM
resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.terra-VNeT-nic.id
  network_security_group_id = azurerm_network_security_group.react.id
}