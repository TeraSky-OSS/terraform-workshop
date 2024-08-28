variable "vsphere_user" {
  description = "vSphere user name"
  type        = string
}

variable "vsphere_password" {
  description = "vSphere password"
  type        = string
}

variable "vsphere_address" {
  description = "vSphere address"
  type        = string
}

variable "datacenter" {
  description = "vSphere datacenter name"
  type        = string
}

variable "datastore" {
  description = "vSphere datastore name"
  type        = string
}

variable "resource_pool" {
  description = "vSphere resource pool name"
  type        = string
}

variable "network" {
  description = "vSphere network name"
  type        = string
}

variable "vm_folder" {
  description = "vSphere VM folder name"
  type        = string
}

variable "vm_template" {
  description = "vSphere VM template name"
  type        = string
}

variable "ipv4_address" {
  description = "IPv4 address for the VM"
  type        = string
}

variable "ipv4_mask" {
  description = "IPv4 netmask for the VM"
  type        = number
  default     = 24
}

variable "ipv4_gw" {
  description = "IPv4 gateway for the VM"
  type        = string
  default     = "172.16.204.1"
}

variable "computer_name" {
  description = "Computer name for the VM"
  type        = string
}

variable "vmName" {
  description = "VM name"
  type        = string
}