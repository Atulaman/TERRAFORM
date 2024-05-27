#creating resource group
resource "azurerm_resource_group" "kuber" {
  name     = "kuber"
  location = "central us"
  tags = {
    environment = var.environment
  }
}