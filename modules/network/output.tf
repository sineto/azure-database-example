output "resource_group" {
  value = azurerm_resource_group.rg
}

output "virtual_network" {
  value = azurerm_virtual_network.vnet
}

output "subnet" {
  value = azurerm_subnet.subnet
}

output "public_ip" {
  value = azurerm_public_ip.pip
}

output "bastion_host" {
  value = azurerm_bastion_host.bastion_host
}
