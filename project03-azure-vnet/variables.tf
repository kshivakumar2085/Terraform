variable "resource_group_name" {
  description = "Resource group name"
  type        = string
  default     = "network-rg"
}

variable "location" {
  description = "Location"
  type        = string
  default     = "Central US"
}

variable "vnet_name" {
  description = "VNet name"
  type        = string
  default     = "example-vnet"
}

variable "address_space" {
  description = "Address space for VNet"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}
