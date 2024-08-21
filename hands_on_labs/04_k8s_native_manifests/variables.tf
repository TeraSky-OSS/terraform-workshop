variable "aws_region" {
  description = "AWS Region to deploy the VPC in"
  type        = string
  default     = "us-east-1"
}

variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
  type    = string
  default = "terraform-workshop"
}