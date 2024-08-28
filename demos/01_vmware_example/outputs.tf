output "tmplate" {
  value = data.vsphere_virtual_machine.template
}

output "vmnames" {
  value = module.example-server-windowsvm-advanced.VM
}

output "vmnameswip" {
  value = module.example-server-windowsvm-advanced.ip
}

output "module" {
  value = module.example-server-windowsvm-advanced
}