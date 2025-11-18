variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "terraform-storage-rg"
}

variable "location" {
  description = "The Azure region"
  type        = string
  default     = "East US"
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
  default     = "terraformstorageacc"
}
