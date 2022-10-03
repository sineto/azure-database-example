variable "network_interface_name" {
  type        = string
  description = "Name for the network interface"
}

variable "location" {
  type        = any
  description = "Location for the network interface"
}

variable "resource_group_name" {
  type        = any
  description = "Resource Group name for the network interface"
}

variable "network_interface_ipconfig_name" {
  type        = any
  description = "Name for the network interface IP configuration name"
}

variable "network_interface_ipconfig_subnet_id" {
  type        = any
  description = "Subnet ID for the network interface IP configuration"
}

variable "linux_vm_name" {
  type        = string
  description = "Name for the Linux Virtual Machine"
}

variable "linux_vm_size" {
  type        = string
  description = "The SKU which should be used for the Linux Virtual Machine"
}

variable "linux_vm_ssh_key" {
  type        = string
  description = "The SSH key which should be used for the Linux Virtual Machine"
}
