variable "resource_group_name" {
  description = "RG for AKS"
  type        = string
  default     = "aks-rg"
}

variable "location" {
  description = "Location for AKS"
  type        = string
  default     = "East US 2"
}

variable "cluster_name" {
  description = "AKS cluster name"
  type        = string
  default     = "my-aks-cluster"
}
