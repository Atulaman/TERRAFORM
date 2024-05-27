resource "azurerm_resource_group" "kuber" {
  name = "kuber"
  location = "east us"
  tags = {
    environment = "development"
  }
}