# output "eks_cluster_name" {
#   description = "The name of the EKS cluster"
#   value       = module.eks.cluster_name
# }

# output "eks_cluster_endpoint" {
#   description = "The endpoint for the EKS Kubernetes API"
#   value       = module.eks.cluster_endpoint
# }

# output "eks_cluster_certificate_authority_data" {
#   description = "The base64 encoded certificate data required to communicate with the cluster"
#   value       = module.eks.cluster_certificate_authority_data
# }

output "eks_update_kubeconfig_command" {
  description = "Command to update kubeconfig file with the EKS cluster credentials"
  value       = "aws eks update-kubeconfig --name ${module.eks.cluster_name} --region ${var.aws_region}"
}