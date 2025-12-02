output "storage_account_id" {
  description = "The ID of the created storage account"
  value       = azurerm_storage_account.sa.id
}

output "storage_account_name" {
  description = "The name of the storage account"
  value       = azurerm_storage_account.sa.name
}

output "primary_web_endpoint" {
  description = "The endpoint URL for the static website"
  value       = azurerm_storage_account.sa.primary_web_endpoint
}

output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.rg.name
}

output "resource_group_id" {
  description = "The ID of the resource group"
  value       = azurerm_resource_group.rg.id
}
