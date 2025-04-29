# Kubernetes Helm Integration with Terraform

This hands-on lab demonstrates how to use Terraform to deploy applications to Kubernetes using Helm charts. The lab specifically shows how to:

1. Deploy an Nginx application using the official Bitnami Helm chart
2. Configure the application with custom values through a values file
3. Set up an Application Load Balancer (ALB) ingress controller for external access
4. Integrate Helm releases with Terraform state management

## Components

- **Nginx Helm Chart**: Deployed using the official Bitnami repository
- **Ingress Configuration**: Set up with ALB ingress controller for external access
- **Service Configuration**: Configured as ClusterIP type
- **Replica Count**: Set to 1 instance

## Prerequisites

- A running EKS cluster
- AWS CLI configured with appropriate credentials
- kubectl configured to access the EKS cluster
- Helm installed locally

---

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.15 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.32 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.64.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.15.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.nginx](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region in which the EKS cluster is deployed | `string` | `"us-east-1"` | no |
| <a name="input_eks_cluster_name"></a> [eks\_cluster\_name](#input\_eks\_cluster\_name) | Name of the EKS cluster | `string` | `"terraform-workshop"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_release_output"></a> [release\_output](#output\_release\_output) | n/a |
<!-- END_TF_DOCS -->