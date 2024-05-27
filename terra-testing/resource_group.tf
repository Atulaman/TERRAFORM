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
      environment = "staging"
    }
  
}

#creating virtual network
resource "azurerm_virtual_network" "terra-VNeT" {
    name = "terra-VNeT"
    resource_group_name = azurerm_resource_group.kuber.name
    location = azurerm_resource_group.kuber.location
    address_space = [ "192.168.1.0/24" ]
    tags = {
      environment = "staging"
    }
}

#creating NSG
resource "azurerm_network_security_group" "react" {
    name = "react"
    resource_group_name = azurerm_resource_group.kuber.name
    location = azurerm_resource_group.kuber.location
    tags = {
      environment = "staging"
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
    ip_version = "IPv4"
    sku = "Standard"
    allocation_method = "Static"
    idle_timeout_in_minutes = 4
    ip_tags = {
      environment = "Terraform-public-ip"
    }
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