# craeting linux virtual machine
resource "azurerm_linux_virtual_machine" "react" {
  name                  = "react"
  resource_group_name   = azurerm_resource_group.kuber.name
  location              = azurerm_resource_group.kuber.location
  size                  = "Standard_D2as_v5"
  admin_username        = "azureuser"
  network_interface_ids = [azurerm_network_interface.terra-VNeT-nic.id]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    name                 = var.os-disk-name
    caching              = var.os-disk-caching
    storage_account_type = "Standard_LRS"
    disk_size_gb         = var.os-disk_size_gb
  }

  source_image_reference {
    publisher = var.image-publisher
    offer     = var.image-offer
    sku       = var.image-sku
    version   = var.image-version
  }
  connection {
        host = azurerm_public_ip.VM-ip.ip_address
        user = "azureuser"
        type = "ssh"
        private_key = "${file("~/.ssh/id_rsa")}"
        timeout = "4m"
        agent = false
  }
  provisioner "remote-exec" {
    inline = [ 
      "sudo apt update",
      "sudo apt upgrade -y",
      "sudo apt install -y nginx",
      "sudo systemctl restart nginx"
    ]
    
  }
  
}