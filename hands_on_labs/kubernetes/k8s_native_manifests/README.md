# Kubernetes Native Manifests with Terraform

This hands-on lab demonstrates how to use Terraform to create and manage Kubernetes resources using native Kubernetes manifests. The lab shows how to:

- Create a Kubernetes namespace
- Deploy a sample nginx application with:
  - Resource limits and requests
  - Health checks (liveness probe)
  - Multiple replicas
  - Custom labels

## Prerequisites

- An AWS EKS cluster already running
- AWS CLI configured with appropriate credentials
- `kubectl` installed and configured
- Terraform installed

## Lab Structure

- `namespace.tf`: Creates a Kubernetes namespace
- `deployment.tf`: Creates a Kubernetes deployment running nginx
- `terraform.tf`: Configures the Kubernetes provider and AWS authentication
- `variables.tf`: Defines input variables for AWS region and EKS cluster name

## Usage

1. Ensure your AWS credentials are configured
2. Update the variables in `variables.tf` if your EKS cluster name or region is different
3. Initialize Terraform:
   ```bash
   terraform init
   ```
4. Review the planned changes:
   ```bash
   terraform plan
   ```
5. Apply the configuration:
   ```bash
   terraform apply
   ```

## Expected Results

After applying the configuration, you should see:
- A new namespace named "example"
- A deployment running 3 replicas of nginx
- The deployment will have resource limits and health checks configured

You can verify the deployment using:
```bash
kubectl get pods -n example
kubectl describe deployment terraform-example -n example
```

---

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.32 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.63.1 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.32.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_deployment_v1.deployment_2048](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment_v1) | resource |
| [kubernetes_ingress_v1.ingress_2048](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/ingress_v1) | resource |
| [kubernetes_namespace.game_2048](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
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