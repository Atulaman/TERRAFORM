resource "azurerm_storage_container" "state-file" {
  name = "state-file"
  storage_account_name = azurerm_storage_account.storage-backend.name
  container_access_type = "private"
}