variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "vm-resource-group"
}

variable "location" {
  description = "The Azure region"
  type        = string
  default     = "East US"
}

variable "vm_name" {
  description = "Name of the VM"
  type        = string
  default     = "example-vm"
}

variable "admin_username" {
  description = "Admin username for VM"
  type        = string
  default     = "azureuser"
}
