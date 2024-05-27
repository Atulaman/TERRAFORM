# Create an Azure Container Instance
resource "azurerm_container_group" "my_app" {
  name                = "my_app"
  location            = azurerm_resource_group.react.location
  resource_group_name = azurerm_resource_group.react.name
  os_type             = "Linux"

  container {
    name   = "my_app"
    image  = "${azurerm_container_registry.myregistry.login_server}/react:latest"  # Replace with your image reference
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 8080
      protocol = "TCP"
    }

    environment_variables = {
      # Define environment variables if needed
    }
  }

  tags = {
    environment = "Devlopment"
  }
}