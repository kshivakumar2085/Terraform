variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "storage-rg"
}

variable "location" {
  description = "Azure location"
  type        = string
  default     = "West US"
}

variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
  default     = "mystorageaccount"
}
