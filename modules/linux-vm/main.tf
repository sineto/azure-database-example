resource "azurerm_network_interface" "network_interface" {
  name                = var.network_interface_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = var.network_interface_ipconfig_name
    subnet_id                     = var.network_interface_ipconfig_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "linux-vm" {
  name                = var.linux_vm_name
  location            = var.location
  resource_group_name = var.resource_group_name

  size                  = var.linux_vm_size
  network_interface_ids = [azurerm_network_interface.network_interface.id]

  admin_username = "azureuser"

  admin_ssh_key {
    username   = "azureuser"
    public_key = file(var.linux_vm_ssh_key)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
