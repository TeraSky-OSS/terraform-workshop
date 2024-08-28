variable "aws_region" {
  description = "AWS Region in which the EKS cluster is deployed"
  type        = string
  default     = "us-east-1"
}

variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "terraform-workshop"
}