variable "resource_group_name" {
  type        = string
  description = "Name of Resource Group"
}

variable "resource_group_location" {
  type        = string
  description = "Name of Resource Group"
  default     = "East US"
}

variable "virtual_network_name" {
  type        = string
  description = "Name of the Virtual Network"
}

variable "virtual_network_address_space" {
  type        = list(string)
  description = "The address space that is used the virtual network"
}

variable "subnet_name" {
  type        = string
  description = "Name of the subnet"
}

variable "subnet_address_prefixes" {
  type        = list(string)
  description = "The address prefixes to use for the subnet"
}

variable "public_ip_name" {
  type        = string
  description = "Name of the public IP address"
}

variable "public_ip_allocation_method" {
  type        = string
  description = "Defines the allocation method for the IP address"
  default     = "Static"
}

variable "public_ip_sku" {
  type        = string
  description = "The SKU of the public IP"
  default     = "Basic"
}

variable "bastion_name" {
  type        = string
  description = "Name of the Bastion Host"
}
