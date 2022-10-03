module "azurerm_network" {
  source = "./modules/network"

  resource_group_name     = "rg-database"
  resource_group_location = var.azure_location

  virtual_network_name          = "vnet-database"
  virtual_network_address_space = ["10.0.0.0/16"]

  subnet_name             = "subnet-database"
  subnet_address_prefixes = ["10.0.1.0/24"]

  public_ip_name = "bastion-host-public-ip"
  public_ip_sku  = "Standard"
  bastion_name   = "bastion-host"
}

resource "azurerm_ssh_public_key" "ssh_key" {
  name                = "demo-keypair"
  location            = module.azurerm_network.resource_group.location
  resource_group_name = module.azurerm_network.resource_group.name
  public_key          = file(var.ssh_pub_key_path)
}

module "linux_vm" {
  source = "./modules/linux-vm"

  location            = module.azurerm_network.resource_group.location
  resource_group_name = module.azurerm_network.resource_group.name

  network_interface_name               = "linux-vm-database-nic"
  network_interface_ipconfig_name      = "linux-vm-database-nic-internal"
  network_interface_ipconfig_subnet_id = module.azurerm_network.subnet.id

  linux_vm_name    = "linux-vm-database"
  linux_vm_size    = "Standard_B1s"
  linux_vm_ssh_key = var.ssh_pub_key_path
}

resource "azurerm_subnet" "pg_subnet" {
  name                 = "pg-subnet-database"
  resource_group_name  = module.azurerm_network.resource_group.name
  virtual_network_name = module.azurerm_network.virtual_network.name
  address_prefixes     = ["10.0.2.0/24"]
  service_endpoints    = ["Microsoft.Storage"]

  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action"
      ]
    }
  }
}

resource "azurerm_private_dns_zone" "pg_dns_zone" {
  name                = "pgdemosn.postgres.database.azure.com"
  resource_group_name = module.azurerm_network.resource_group.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "pg_dns_zone_link" {
  name                  = "pgdemosn"
  resource_group_name   = module.azurerm_network.resource_group.name
  virtual_network_id    = module.azurerm_network.virtual_network.id
  private_dns_zone_name = azurerm_private_dns_zone.pg_dns_zone.name
}

resource "azurerm_postgresql_flexible_server" "pg_server" {
  name                = "pg-server-database"
  location            = module.azurerm_network.resource_group.location
  resource_group_name = module.azurerm_network.resource_group.name

  administrator_login    = "pgdemo"
  administrator_password = "Admin12345"
  version                = "14"
  sku_name               = "B_Standard_B1ms"
  storage_mb             = 32768

  delegated_subnet_id = azurerm_subnet.pg_subnet.id
  private_dns_zone_id = azurerm_private_dns_zone.pg_dns_zone.id

  depends_on = [azurerm_private_dns_zone_virtual_network_link.pg_dns_zone_link]
}
