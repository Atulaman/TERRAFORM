resource "azurerm_storage_account" "storage-backend" {
  name = "backend21"
  resource_group_name = azurerm_resource_group.kuber.name
  location = azurerm_resource_group.kuber.location
  account_tier = "Standard"
  account_replication_type = "LRS"
  /*network_rules {
    default_action = "Allow"
    virtual_network_subnet_ids = [ azurerm_subnet.default.id ]
  }*/
}
