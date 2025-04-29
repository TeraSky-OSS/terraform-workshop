data "vsphere_datacenter" "datacenter" {
  name = var.datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

# data "vsphere_compute_cluster" "cluster" {
#   name          = "LAB-V3"
#   datacenter_id = data.vsphere_datacenter.datacenter.id
# }

data "vsphere_resource_pool" "pool" {
  name          = var.resource_pool
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "network" {
  name          = var.network
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_folder" "folder" {
  path = "${var.datacenter}/vm/${var.vm_folder}"
}

data "vsphere_virtual_machine" "template" {
  name          = var.vm_template
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

module "example-server-windowsvm-advanced" {
  source  = "Terraform-VMWare-Modules/vm/vsphere"
  version = "3.8.0"

  dc           = data.vsphere_datacenter.datacenter.name
  vmrp         = data.vsphere_resource_pool.pool.name
  vmfolder     = var.vm_folder
  datastore    = data.vsphere_datastore.datastore.name
  vmtemp       = var.vm_template
  instances    = 1
  vmname       = var.vmName
  vmnameformat = "%03d" #To use three decimal with leading zero vmnames will be AdvancedVM001,AdvancedVM002
  domain       = "somedomain.com"
  cpu_number   = 8
  ram_size     = 8192

  network = {
    "${data.vsphere_network.network.name}" = [var.ipv4_address]
  }

  ipv4submask  = [var.ipv4_mask]
  network_type = [data.vsphere_virtual_machine.template.network_interfaces.0.adapter_type]

  scsi_bus_sharing = data.vsphere_virtual_machine.template.scsi_bus_sharing // The modes are physicalSharing, virtualSharing, and noSharing
  scsi_type        = data.vsphere_virtual_machine.template.scsi_type        // Other acceptable value "pvscsi"
  scsi_controller  = 0                                                      // This will assign OS disk to controller 0
  dns_server_list  = ["172.16.20.10", "8.8.8.8"]
  enable_disk_uuid = true
  vmgateway        = var.ipv4_gw
  auto_logon       = true
  run_once         = [""] // You can also run Powershell commands
  orgname          = "Terraform-Module"
  workgroup        = "Module-Test"
  is_windows_image = true
  firmware         = "efi"
  local_adminpass  = "Password@Strong"
}