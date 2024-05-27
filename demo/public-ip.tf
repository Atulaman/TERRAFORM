#creating public ip
resource "azurerm_public_ip" "VM-ip" {
    name = "VM-ip"
    resource_group_name = azurerm_resource_group.kuber.name
    location = azurerm_resource_group.kuber.location
    //ip_version = "IPv4"
    //sku = "Standard"
    allocation_method = "Static"
    //idle_timeout_in_minutes = 4
    tags = {
      environment = var.environment
    }
}
