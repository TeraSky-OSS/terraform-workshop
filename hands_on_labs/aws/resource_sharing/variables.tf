variable "aws_region" {
  description = "Name of AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_name" {
  description = "Name of VPC"
  type        = string
  default     = "terraform-workshop-vpc-lab"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones to use"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "allow_external_principals" {
  description = "Whether to allow external principals to access the shared resources"
  type        = bool
  default     = false
}

variable "ram_principals" {
  description = "List of AWS account IDs or organization ARNs to share the subnets with"
  type        = list(string)
}