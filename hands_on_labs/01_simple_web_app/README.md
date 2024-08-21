<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.63 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.63.1 |
| <a name="provider_http"></a> [http](#provider\_http) | 3.4.4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_instance.web](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_security_group.allow_current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_ami.nginx](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |
| [aws_subnet.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_vpc.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |
| [http_http.myip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_name_filters"></a> [ami\_name\_filters](#input\_ami\_name\_filters) | Name filter for searching AMI | `list(string)` | <pre>[<br>  "bitnami-nginx-1.27.0-0-linux-debian-12-x86_64-hvm-ebs-nami"<br>]</pre> | no |
| <a name="input_ami_owners"></a> [ami\_owners](#input\_ami\_owners) | List of AMI owners to limit search. At least 1 value must be specified. Valid values: an AWS account ID, self (the current account), or an AWS owner alias (e.g. amazon, aws-marketplace, microsoft) | `list(string)` | <pre>[<br>  "979382823631"<br>]</pre> | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | Name of AWS region | `string` | `"us-east-1"` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | Name of EC2 instance | `string` | `"terraform-workshop-web"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Type of instance to start. Updates to this field will trigger a stop/start of the EC2 instance | `string` | `"t3.small"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_ip"></a> [instance\_ip](#output\_instance\_ip) | n/a |
<!-- END_TF_DOCS -->