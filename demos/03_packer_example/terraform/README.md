# Packer AMI Demo

This demo demonstrates how to use a custom AMI (Amazon Machine Image) built with Packer in a Terraform configuration. The demo includes:

- Using a data source to find the most recent AMI matching specified filters
- Creating an EC2 instance with the selected AMI
- Setting up security groups to allow access from your current IP address
- Using existing VPC and subnet infrastructure
- Configuring the instance with public IP access

## Usage

To use this demo, you'll need to provide values for the following required variables:
- `ami_name_filters`: List of name patterns to filter AMIs
- `ami_owners`: List of AMI owners (e.g., your AWS account ID or "self")

Optional variables include:
- `aws_region`: AWS region to deploy to (defaults to us-east-1)
- `instance_name`: Name for the EC2 instance
- `instance_type`: EC2 instance type (defaults to t3.micro)
- `vpc_name`: Name of the VPC to use (defaults to terraform-workshop-vpc)
- `selected_subnet_tier`: Subnet tier to use (defaults to public)

The demo will create an EC2 instance with the specified AMI and output its public IP address.

---

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.63.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_instance.web](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_security_group.allow_current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_ami.packer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |
| [aws_subnets.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_name_filters"></a> [ami\_name\_filters](#input\_ami\_name\_filters) | Name filter for searching AMI | `list(string)` | n/a | yes |
| <a name="input_ami_owners"></a> [ami\_owners](#input\_ami\_owners) | List of AMI owners to limit search. At least 1 value must be specified. Valid values: an AWS account ID, self (the current account), or an AWS owner alias (e.g. amazon, aws-marketplace, microsoft) | `list(string)` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | Name of AWS region | `string` | `"us-east-1"` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | Name of EC2 instance | `string` | `""` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Type of instance to start. Updates to this field will trigger a stop/start of the EC2 instance | `string` | `"t3.micro"` | no |
| <a name="input_selected_subnet_tier"></a> [selected\_subnet\_tier](#input\_selected\_subnet\_tier) | Tier of subnet to use | `string` | `"public"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name of VPC | `string` | `"terraform-workshop-vpc"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_ip"></a> [instance\_ip](#output\_instance\_ip) | n/a |
<!-- END_TF_DOCS -->