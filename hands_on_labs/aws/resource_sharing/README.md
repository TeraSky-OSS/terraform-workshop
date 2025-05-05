# VPC and Subnet Sharing Lab

This hands-on lab demonstrates how to create a VPC with public and private subnets and share them using AWS Resource Access Manager (RAM) using Terraform. The lab creates a complete network infrastructure including:

1. A VPC with a specified CIDR block
2. Public and private subnets across multiple availability zones
3. Internet Gateway for public subnet access
4. NAT Gateways for private subnet internet access
5. Route tables for public and private subnets
6. RAM resource share for subnet sharing with other AWS accounts

## Overview

This lab will:
1. Create a VPC with DNS support enabled
2. Create public and private subnets in multiple availability zones
3. Set up an Internet Gateway and NAT Gateways
4. Configure route tables for public and private subnets
5. Share subnets with other AWS accounts using RAM

## Prerequisites

- AWS account with appropriate permissions
- Terraform installed (version ~> 1.0)
- AWS CLI configured with your credentials
- If sharing subnets, target AWS accounts must be known

## Usage

1. Navigate to this directory:
   ```bash
   cd hands_on_labs/aws/resource_sharing
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```

3. Review the planned changes:
   ```bash
   terraform plan
   ```

4. Apply the configuration:
   ```bash
   terraform apply
   ```

## Subnet Sharing

To share subnets with other AWS accounts, you can use the following variables:

```hcl
ram_principals = ["123456789012", "arn:aws:organizations::123456789012:organization/o-xxxxxxxxxx"]
allow_external_principals = true
```

Where:
- `ram_principals`: List of AWS account IDs or organization ARNs to share the subnets with
- `allow_external_principals`: Whether to allow external principals to access the shared resources

## Cleanup

To destroy the infrastructure:
```bash
terraform destroy
```

## Architecture

The lab creates the following architecture:
- A VPC with public and private subnets
- An Internet Gateway for public subnet internet access
- NAT Gateways for private subnet internet access
- Route tables with appropriate routes for both public and private subnets
- RAM resource share for subnet sharing

## Variables

The following variables can be customized:
- `aws_region`: AWS region to deploy resources (default: us-east-1)
- `vpc_name`: Name of the VPC (default: terraform-workshop-vpc)
- `vpc_cidr`: CIDR block for the VPC (default: 10.0.0.0/16)
- `availability_zones`: List of availability zones to use (default: ["us-east-1a", "us-east-1b"])
- `ram_principals`: List of AWS account IDs or organization ARNs to share the subnets with (default: [])
- `allow_external_principals`: Whether to allow external principals to access the shared resources (default: false)

---

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.63 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.96.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_internet_gateway.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_ram_principal_association.subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_principal_association) | resource |
| [aws_ram_resource_association.private_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_association) | resource |
| [aws_ram_resource_association.public_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_association) | resource |
| [aws_ram_resource_share.subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_share) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_external_principals"></a> [allow\_external\_principals](#input\_allow\_external\_principals) | Whether to allow external principals to access the shared resources | `bool` | `false` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | List of availability zones to use | `list(string)` | <pre>[<br/>  "us-east-1a",<br/>  "us-east-1b"<br/>]</pre> | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | Name of AWS region | `string` | `"us-east-1"` | no |
| <a name="input_ram_principals"></a> [ram\_principals](#input\_ram\_principals) | List of AWS account IDs or organization ARNs to share the subnets with | `list(string)` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR block for the VPC | `string` | `"10.0.0.0/16"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name of VPC | `string` | `"terraform-workshop-vpc"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | n/a |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | n/a |
| <a name="output_ram_resource_share_arn"></a> [ram\_resource\_share\_arn](#output\_ram\_resource\_share\_arn) | ARN of the RAM resource share |
| <a name="output_ram_resource_share_id"></a> [ram\_resource\_share\_id](#output\_ram\_resource\_share\_id) | ID of the RAM resource share |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |
<!-- END_TF_DOCS -->