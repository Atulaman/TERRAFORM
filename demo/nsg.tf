#creating NSG
resource "azurerm_network_security_group" "react" {
    name = "react"
    resource_group_name = azurerm_resource_group.kuber.name
    location = azurerm_resource_group.kuber.location
    tags = {
      environment = var.environment
    }
    security_rule {
    name                       = "AllowHTTP"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = var.http-port
    source_address_prefix      = "*"
    destination_address_prefix = azurerm_public_ip.VM-ip.ip_address
  }
  security_rule {
    name                       = "AllowHTTPS"
    priority                   = 310
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = var.https-port
    source_address_prefix      = "*"
    destination_address_prefix = azurerm_public_ip.VM-ip.ip_address
  }
  security_rule {
    name                       = "AllowSSH"
    priority                   = 320
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = var.ssh-port
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}