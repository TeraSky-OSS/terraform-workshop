terraform {
  backend "s3" {}
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Terraform = "True"
      Project   = "Terraform Workshop"
    }
  }
}

locals {
  eks_cluster_endpoint = var.create_eks_cluster ? module.eks.cluster_endpoint : ""
  eks_cluster_ca_data  = var.create_eks_cluster ? base64decode(module.eks.cluster_certificate_authority_data) : ""
  eks_cluster_name     = var.create_eks_cluster ? module.eks.cluster_name : ""
}

provider "kubernetes" {
  host                   = local.eks_cluster_endpoint
  cluster_ca_certificate = local.eks_cluster_ca_data
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", local.eks_cluster_name]
    command     = "aws"
  }
}

provider "helm" {
  kubernetes {
    host                   = local.eks_cluster_endpoint
    cluster_ca_certificate = local.eks_cluster_ca_data
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", local.eks_cluster_name]
      command     = "aws"
    }
  }
}