#creating NIC
resource "azurerm_network_interface" "terra-VNeT-nic" {
  name                = "terra-VNeT-nic"
  resource_group_name = azurerm_resource_group.kuber.name
  location            = azurerm_resource_group.kuber.location
  ip_configuration {
    name                          = "teera-nic-ip"
    subnet_id                     = azurerm_subnet.default.id
    private_ip_address_allocation = "Dynamic"
    private_ip_address_version    = "IPv4"
    public_ip_address_id          = azurerm_public_ip.VM-ip.id
  }
  provisioner "local-exec" {
    //command = "hostname -I | awk '{print $1}' > server_ip.txt"
    command = "echo ${self.private_ip_address} >> private_ip.txt"
  }
}