/*terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.0.0"
    }
  }
}
*/
# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}


#creating resource group
resource "azurerm_resource_group" "kuber" {
    name = "kuber"
    location = "central us"
    tags = {
      environment = var.environment
    }
  
}

#creating virtual network
resource "azurerm_virtual_network" "terra-VNeT" {
    name = "terra-VNeT"
    resource_group_name = azurerm_resource_group.kuber.name
    location = azurerm_resource_group.kuber.location
    address_space = [ "192.168.1.0/24" ]
    tags = {
      environment = var.environment
    }
}

#creating NSG
resource "azurerm_network_security_group" "react" {
    name = "react"
    resource_group_name = azurerm_resource_group.kuber.name
    location = azurerm_resource_group.kuber.location
    tags = {
      environment = var.environment
    }
    security_rule {
    name                       = "AllowHTTP"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = var.http-port
    source_address_prefix      = "*"
    destination_address_prefix = azurerm_public_ip.VM-ip.ip_address
  }
  security_rule {
    name                       = "AllowHTTPS"
    priority                   = 310
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = var.https-port
    source_address_prefix      = "*"
    destination_address_prefix = azurerm_public_ip.VM-ip.ip_address
  }
  security_rule {
    name                       = "AllowSSH"
    priority                   = 320
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = var.ssh-port
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

#creating subnet
resource "azurerm_subnet" "default" {
    name = "default"
    resource_group_name = azurerm_resource_group.kuber.name
    virtual_network_name = azurerm_virtual_network.terra-VNeT.name
    address_prefixes = [ "192.168.1.0/25" ]
    
}

#creating public ip
resource "azurerm_public_ip" "VM-ip" {
    name = "VM-ip"
    resource_group_name = azurerm_resource_group.kuber.name
    location = azurerm_resource_group.kuber.location
    //ip_version = "IPv4"
    //sku = "Standard"
    allocation_method = "Static"
    //idle_timeout_in_minutes = 4
    /*ip_tags = {
      environment = "Terraform-public-ip"
    }*/
}

#creating NIC
resource "azurerm_network_interface" "terra-VNeT-nic" {
    name = "terra-VNeT-nic"
    resource_group_name = azurerm_resource_group.kuber.name
    location = azurerm_resource_group.kuber.location
    ip_configuration {
        name = "teera-nic-ip"
        subnet_id = azurerm_subnet.default.id
        private_ip_address_allocation = "Dynamic"
        private_ip_address_version = "IPv4"
        public_ip_address_id = azurerm_public_ip.VM-ip.id
    }
}

#creating Virtual Machine
resource "azurerm_virtual_machine" "react" {
  name = "react"
  resource_group_name = azurerm_resource_group.kuber.name
  location = azurerm_resource_group.kuber.location
  network_interface_ids = [azurerm_network_interface.terra-VNeT-nic.id]
  vm_size = "Standard_D2as_v5"
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

}

#apply NSG to VM
resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id    = azurerm_network_interface.terra-VNeT-nic.id
  network_security_group_id = azurerm_network_security_group.react.id
}

#OUTPUT Demo
output "public-ip" {
  value = azurerm_public_ip.VM-ip.ip_address
}
output "virtual-machine" {
  value = azurerm_virtual_machine.react.id
}