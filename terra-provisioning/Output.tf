#OUTPUT Demo
output "public-ip" {
  value = azurerm_public_ip.VM-ip.ip_address
}
output "virtual-machine" {
  value = azurerm_linux_virtual_machine.react.private_ip_address
}