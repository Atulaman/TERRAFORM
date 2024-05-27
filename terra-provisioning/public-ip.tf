#creating public ip
resource "azurerm_public_ip" "VM-ip" {
  name                = "VM-ip"
  resource_group_name = azurerm_resource_group.kuber.name
  location            = azurerm_resource_group.kuber.location
  allocation_method   = "Static"
  tags = {
    environment = var.environment
  }
}
