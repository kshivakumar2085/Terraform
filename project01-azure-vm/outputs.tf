output "public_ip_address" {
  description = "The public IP address of the VM"
  value       = azurerm_public_ip.example.ip_address
}

output "vm_id" {
  description = "The ID of the VM"
  value       = azurerm_linux_virtual_machine.example.id
}
