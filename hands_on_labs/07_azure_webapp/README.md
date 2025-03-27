# Deploying a Virtual Machine on Azure with Terraform

This hands-on lab will guide you through deploying a virtual machine on Azure using Terraform. You'll learn how to:
- Set up Azure infrastructure using Infrastructure as Code (IaC)
- Deploy a Linux virtual machine
- Configure network security
- Set up a web server
- Implement security best practices

## Prerequisites

- Azure subscription
- Azure CLI installed
- Terraform installed (version 1.0.0 or later)
- SSH key pair (for VM access)
- Basic understanding of:
  - Azure services
  - Terraform
  - Linux administration
  - Basic networking concepts

## Getting Started

1. Clone this repository
2. Navigate to the `07_azure_webapp` directory
3. Follow the step-by-step instructions below

## Step 1: Azure Setup

1. Login to Azure CLI:
   ```bash
   az login
   ```

2. Set your subscription:
   ```bash
   az account set --subscription <your-subscription-id>
   ```

## Step 2: Generate SSH Key (if not already done)

1. Generate an SSH key pair:
   ```bash
   ssh-keygen -t rsa -b 4096
   ```

2. Press Enter to accept the default location (`~/.ssh/id_rsa`)
3. Enter a passphrase (or press Enter for no passphrase)

## Step 3: Initialize Terraform

1. Navigate to the terraform directory:
   ```bash
   cd terraform
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```

## Step 4: Deploy Infrastructure

1. Review the planned changes:
   ```bash
   terraform plan
   ```

2. Apply the infrastructure:
   ```bash
   terraform apply
   ```

## Step 5: Access the Virtual Machine

1. After deployment, you'll see the SSH command in the outputs
2. Use the provided SSH command to connect to your VM:
   ```bash
   ssh azureuser@<public-ip>
   ```

3. Once connected, verify the web server is running:
   ```bash
   systemctl status nginx
   ```

4. Access the web application by opening a browser and navigating to:
   ```
   http://<public-ip>
   ```

## Step 6: Cleanup

To remove all resources:
```bash
terraform destroy
```

## Learning Objectives

By completing this lab, you will understand:
- How to use Terraform for Azure infrastructure deployment
- Virtual machine deployment and configuration
- Network security group setup
- Basic Linux system administration
- Infrastructure as Code best practices

---

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.24 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 4.24 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_network_interface.nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_security_group.nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_public_ip.pip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_machine_extension.web_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | Admin username for the virtual machine | `string` | `"azureuser"` | no |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Name of the application | `string` | `"webapp-demo"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name (e.g., dev, prod) | `string` | `"dev"` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure region where resources will be created | `string` | `"eastus"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group | `string` | `"rg-webapp-demo"` | no |
| <a name="input_ssh_public_key_path"></a> [ssh\_public\_key\_path](#input\_ssh\_public\_key\_path) | Path to the SSH public key file | `string` | `"~/.ssh/id_rsa.pub"` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | Azure subscription ID | `string` | `"ddec3d27-4edd-44c3-8d07-e2e4dd3a68e4"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources | `map(string)` | <pre>{<br/>  "Environment": "dev",<br/>  "ManagedBy": "terraform",<br/>  "Project": "vm-demo"<br/>}</pre> | no |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | Size of the virtual machine | `string` | `"Standard_B1s"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_public_ip_address"></a> [public\_ip\_address](#output\_public\_ip\_address) | The public IP address of the virtual machine |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of the resource group |
| <a name="output_ssh_command"></a> [ssh\_command](#output\_ssh\_command) | SSH command to connect to the virtual machine |
| <a name="output_vm_name"></a> [vm\_name](#output\_vm\_name) | The name of the virtual machine |
<!-- END_TF_DOCS -->