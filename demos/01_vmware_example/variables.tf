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
  type = string
}

variable "vm_template" {
  type = string
}

variable "ipv4_address" {
  type = string
}

variable "ipv4_mask" {
  type    = number
  default = 24
}

variable "ipv4_gw" {
  type    = string
  default = "172.16.204.1"
}

variable "computer_name" {
  type = string
}

variable "vmName" {
  type = string
}