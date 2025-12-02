# Backend configuration for remote state (optional - uncomment for production)
# This configuration requires a pre-existing storage account for Terraform state
#
# To use this backend:
# 1. Create a storage account manually: az storage account create --name <tfstate-storage> --resource-group <rg> --location <location>
# 2. Create a container: az storage container create --name tfstate --account-name <tfstate-storage>
# 3. Uncomment the backend block below and replace values
# 4. Run: terraform init

# terraform {
#   backend "azurerm" {
#     resource_group_name  = "<state-rg>"
#     storage_account_name = "<tfstate-storage>"
#     container_name       = "tfstate"
#     key                  = "terraform.tfstate"
#   }
# }
