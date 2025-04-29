variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
  default     = "ddec3d27-4edd-44c3-8d07-e2e4dd3a68e4" # Microsoft Azure Sponsorship
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-webapp-demo"
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
  default     = "eastus"
}

variable "app_name" {
  description = "Name of the application"
  type        = string
  default     = "webapp-demo"
}

variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

variable "vm_size" {
  description = "Size of the virtual machine"
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Admin username for the virtual machine"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key file"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "vm-demo"
    ManagedBy   = "terraform"
    owner       = "daniel@terasky.com"
  }
} 