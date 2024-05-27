resource "azurerm_resource_group" "react" {
  name     = "react"
  location = "central us"
  tags = {
    environment = "Devlopment"
  }
}