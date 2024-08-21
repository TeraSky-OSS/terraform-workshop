#######################################################
# Global
#######################################################

variable "aws_region" {
  description = "Name of the AWS region"
  type        = string
  default     = "us-east-1"
}

#######################################################
# VPC
#######################################################

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "terraform-workshop-vpc"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
  default     = "10.0.0.0/16"
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = true # The VPC must have DNS hostname and DNS resolution support. Otherwise, EKS nodes can't register their cluster
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true # The VPC must have DNS hostname and DNS resolution support. Otherwise, EKS nodes can't register their cluster
}

variable "create_igw" {
  description = "Controls if an Internet Gateway is created for public subnets and the related routes that connect them."
  type        = bool
  default     = true
}

variable "enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  type        = bool
  default     = true
}

variable "public_subnet_count" {
  description = "Number of public subnets to create (for dynamic calculation of network CIDRs)"
  type        = number
  default     = 3
}

variable "public_subnet_network_start" {
  description = "Public subnet network (third octet) to dynamically calculate the network CIDRs. Use `public_subnets_cidrs` to provide the network CIDRs manually"
  type        = number
  default     = 1
}

variable "public_subnet_suffix" {
  description = "Suffix to append to public subnets name"
  type        = string
  default     = "public"
}

variable "public_subnet_tags" {
  description = "Additional tags for the public subnets"
  type        = map(string)
  default = {
    Tier                     = "public"
    "kubernetes.io/role/elb" = 1
  }
}

variable "public_route_table_tags" {
  description = "Additional tags for the public route tables"
  type        = map(string)
  default = {
    Tier = "public"
  }
}

variable "map_public_ip_on_launch" {
  description = "Should be false if you do not want to auto-assign public IP on launch"
  type        = bool
  default     = true
}

variable "private_subnet_count" {
  description = "Number of private subnets to create (for dynamic calculation of network CIDRs)"
  type        = number
  default     = 3
}

variable "private_subnet_network_start" {
  description = "Private subnet network (third octet) to dynamically calculate the network CIDRs. Use `private_subnets_cidrs` to provide the network CIDRs manually"
  type        = number
  default     = 101
}

variable "private_subnet_suffix" {
  description = "Suffix to append to private subnets name"
  type        = string
  default     = "private"
}

variable "private_subnet_tags" {
  description = "Additional tags for the private subnets"
  type        = map(string)
  default = {
    Tier                              = "private"
    "kubernetes.io/role/internal-elb" = 1
  }
}

variable "private_route_table_tags" {
  description = "Additional tags for the private route tables"
  type        = map(string)
  default = {
    Tier = "private"
  }
}

#######################################################
# EKS
#######################################################

variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "terraform-workshop"
}

variable "eks_cluster_version" {
  description = "Version of the EKS cluster"
  type        = string
  default     = "1.30"
}