## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.50.0 |
| <a name="provider_http"></a> [http](#provider\_http) | 2.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_instance.web](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_security_group.allow_current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_ami.nginx](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |
| [aws_vpc.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |
| [http_http.myip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_name_filters"></a> [ami\_name\_filters](#input\_ami\_name\_filters) | Name filter for searching AMI | `list(string)` | n/a | yes |
| <a name="input_ami_owners"></a> [ami\_owners](#input\_ami\_owners) | List of AMI owners to limit search. At least 1 value must be specified. Valid values: an AWS account ID, self (the current account), or an AWS owner alias (e.g. amazon, aws-marketplace, microsoft) | `list(string)` | n/a | yes |
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | Name of AWS profile | `string` | `"default"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | Name of AWS region | `string` | `"us-east-1"` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | Name of EC2 instance | `string` | `""` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Type of instance to start. Updates to this field will trigger a stop/start of the EC2 instance | `string` | `"t3.micro"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to apply to resources | `map(string)` | <pre>{<br>  "Terraform": "True"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_ip"></a> [instance\_ip](#output\_instance\_ip) | n/a |
