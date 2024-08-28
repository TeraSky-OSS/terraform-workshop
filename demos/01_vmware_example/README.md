<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_vsphere"></a> [vsphere](#provider\_vsphere) | 2.8.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_example-server-windowsvm-advanced"></a> [example-server-windowsvm-advanced](#module\_example-server-windowsvm-advanced) | Terraform-VMWare-Modules/vm/vsphere | 3.8.0 |

## Resources

| Name | Type |
|------|------|
| [vsphere_datacenter.datacenter](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/datacenter) | data source |
| [vsphere_datastore.datastore](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/datastore) | data source |
| [vsphere_folder.folder](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/folder) | data source |
| [vsphere_network.network](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/network) | data source |
| [vsphere_resource_pool.pool](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/resource_pool) | data source |
| [vsphere_virtual_machine.template](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/virtual_machine) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_computer_name"></a> [computer\_name](#input\_computer\_name) | Computer name for the VM | `string` | n/a | yes |
| <a name="input_datacenter"></a> [datacenter](#input\_datacenter) | vSphere datacenter name | `string` | n/a | yes |
| <a name="input_datastore"></a> [datastore](#input\_datastore) | vSphere datastore name | `string` | n/a | yes |
| <a name="input_ipv4_address"></a> [ipv4\_address](#input\_ipv4\_address) | IPv4 address for the VM | `string` | n/a | yes |
| <a name="input_ipv4_gw"></a> [ipv4\_gw](#input\_ipv4\_gw) | IPv4 gateway for the VM | `string` | `"172.16.204.1"` | no |
| <a name="input_ipv4_mask"></a> [ipv4\_mask](#input\_ipv4\_mask) | IPv4 netmask for the VM | `number` | `24` | no |
| <a name="input_network"></a> [network](#input\_network) | vSphere network name | `string` | n/a | yes |
| <a name="input_resource_pool"></a> [resource\_pool](#input\_resource\_pool) | vSphere resource pool name | `string` | n/a | yes |
| <a name="input_vmName"></a> [vmName](#input\_vmName) | VM name | `string` | n/a | yes |
| <a name="input_vm_folder"></a> [vm\_folder](#input\_vm\_folder) | vSphere VM folder name | `string` | n/a | yes |
| <a name="input_vm_template"></a> [vm\_template](#input\_vm\_template) | vSphere VM template name | `string` | n/a | yes |
| <a name="input_vsphere_address"></a> [vsphere\_address](#input\_vsphere\_address) | vSphere address | `string` | n/a | yes |
| <a name="input_vsphere_password"></a> [vsphere\_password](#input\_vsphere\_password) | vSphere password | `string` | n/a | yes |
| <a name="input_vsphere_user"></a> [vsphere\_user](#input\_vsphere\_user) | vSphere user name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_module"></a> [module](#output\_module) | n/a |
| <a name="output_tmplate"></a> [tmplate](#output\_tmplate) | n/a |
| <a name="output_vmnames"></a> [vmnames](#output\_vmnames) | n/a |
| <a name="output_vmnameswip"></a> [vmnameswip](#output\_vmnameswip) | n/a |
<!-- END_TF_DOCS -->