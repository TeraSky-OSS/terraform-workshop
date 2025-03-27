# Kubernetes Full Application Deployment Lab

This hands-on lab demonstrates how to deploy a complete application (2048 game) to a Kubernetes cluster using Terraform. The lab covers various Kubernetes resources and concepts including:

- Namespace creation and management
- Deployment configuration with multiple replicas
- Service configuration (NodePort)
- Ingress setup with AWS ALB
- Persistent Volume Claims
- Service Accounts
- Resource organization and modularity

## Application Details
The lab deploys the popular 2048 game as a containerized application. The application is exposed through an AWS Application Load Balancer (ALB) ingress controller, making it accessible from the internet.

## Prerequisites
- An AWS EKS cluster already deployed
- AWS CLI configured with appropriate credentials
- kubectl installed and configured
- Terraform installed

## Infrastructure Components
- **Namespace**: Creates an isolated namespace `game-2048` for the application
- **Deployment**: Deploys 5 replicas of the 2048 game container
- **Service**: Exposes the application using NodePort service type
- **Ingress**: Configures an ALB ingress controller for external access
- **PVC**: Sets up persistent storage using AWS EBS volumes
- **Service Account**: Creates a dedicated service account for the application

## Usage
1. Ensure your AWS credentials and EKS cluster access are configured
2. Initialize Terraform: `terraform init`
3. Review the planned changes: `terraform plan`
4. Apply the configuration: `terraform apply`
5. Access the application using the provided endpoint in the outputs

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
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.32.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_deployment_v1.deployment_2048](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment_v1) | resource |
| [kubernetes_ingress_v1.ingress_2048](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/ingress_v1) | resource |
| [kubernetes_namespace.game_2048](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_persistent_volume_claim.demo](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/persistent_volume_claim) | resource |
| [kubernetes_service_account.demo](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) | resource |
| [kubernetes_service_v1.service_2048](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_v1) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region in which the EKS cluster is deployed | `string` | `"us-east-1"` | no |
| <a name="input_eks_cluster_name"></a> [eks\_cluster\_name](#input\_eks\_cluster\_name) | Name of the EKS cluster | `string` | `"terraform-workshop"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_game_2048_endpoint"></a> [game\_2048\_endpoint](#output\_game\_2048\_endpoint) | n/a |
<!-- END_TF_DOCS -->