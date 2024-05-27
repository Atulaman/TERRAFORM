#OUTPUT Demo
output "public-ip" {
  value = azurerm_public_ip.VM-ip.ip_address
}
output "virtual-machine" {
  value = azurerm_virtual_machine.react.id
}