provider "azurerm" {
  features {}

  subscription_id = "bfbc5570-5427-4aac-bcbd-b62eb3e731ef"
}
locals {
  default_tags = {
    environment = "CloudLab"
    project     = "DevOps Portfolio"
  }
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags = local.default_tags

}

resource "azurerm_network_security_group" "nsg" {
  name                = "cloudlab-nsg"
  location            = var.location
  tags = local.default_tags

  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTP-Dev"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = "cloudlab-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  tags = local.default_tags

  resource_group_name = azurerm_resource_group.rg.name
}


resource "azurerm_subnet" "subnet" {
  name                 = "cloudlab-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]

  
}

resource "azurerm_public_ip" "public_ip" {
  name                = "cloudlab-public-ip"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags = local.default_tags
  allocation_method   = "Static"
  
}

resource "azurerm_network_interface" "nic" {
  name                = "cloudlab-nic"
  location            = var.location
  tags = local.default_tags

  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                  = "cloudlab-vm"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = var.location
  tags = local.default_tags

  size                  = "Standard_B1s"
  admin_username        = var.admin_username
  network_interface_ids = [azurerm_network_interface.nic.id]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.public_key_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}
resource "azurerm_subnet_network_security_group_association" "subnet_nsg" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id

}
