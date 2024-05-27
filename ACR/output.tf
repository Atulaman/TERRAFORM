output "server-login" {
  value     = format("%s", azurerm_container_registry.myregistry.login_server)
  sensitive = false
}