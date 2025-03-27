output "public_ip_address" {
  description = "The public IP address of the virtual machine"
  value       = azurerm_linux_virtual_machine.vm.public_ip_address
}

output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.rg.name
}

output "vm_name" {
  description = "The name of the virtual machine"
  value       = azurerm_linux_virtual_machine.vm.name
}

output "ssh_command" {
  description = "SSH command to connect to the virtual machine"
  value       = "ssh ${var.admin_username}@${azurerm_linux_virtual_machine.vm.public_ip_address}"
}

output "webapp_url" {
  description = "The URL of the deployed web application"
  value       = "http://${azurerm_linux_virtual_machine.vm.public_ip_address}"
}