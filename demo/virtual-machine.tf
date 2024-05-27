#creating Virtual Machine
resource "azurerm_virtual_machine" "react" {
  name = "react"
  resource_group_name = azurerm_resource_group.kuber.name
  location = azurerm_resource_group.kuber.location
  network_interface_ids = [azurerm_network_interface.terra-VNeT-nic.id]
  vm_size = "Standard_D2as_v5"
  delete_os_disk_on_termination = true
  //delete_os_disk_on_deletion = true
  storage_image_reference {
    publisher = var.image-publisher
    offer = var.image-offer
    sku = var.image-sku
    version = var.image-version
  }
  storage_os_disk {
    name = var.os-disk-name
    caching           = var.os-disk-caching
    create_option     = var.os-disk-create_option
    managed_disk_type = var.os-disk-managed_disk_type
    disk_size_gb = var.os-disk_size_gb
  }
  os_profile {
    computer_name  = "remotestate"
    admin_username = "azureuser"
    admin_password = "Mikku@123456"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = var.environment
  }
  provisioner "local-exec" {
    //command = "hostname -I | awk '{print $1}' > server_ip.txt"
    command = "echo ${ self.vm_size } >> NIC.txt"
    on_failure = continue
  }

}