variable "aws_region" {
  description = "Name of AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_name" {
  description = "Name of VPC"
  type        = string
  default     = "terraform-workshop-vpc"
}

variable "selected_subnet_tier" {
  description = "Tier of subnet to use"
  type        = string
  default     = "public"
}

variable "ami_name_filters" {
  description = "Name filter for searching AMI"
  type        = list(string)
  default     = ["bitnami-nginx-1.27.0-0-linux-debian-12-x86_64-hvm-ebs-nami"]
}

variable "ami_owners" {
  description = "List of AMI owners to limit search. At least 1 value must be specified. Valid values: an AWS account ID, self (the current account), or an AWS owner alias (e.g. amazon, aws-marketplace, microsoft)"
  type        = list(string)
  default     = ["979382823631"]
}

variable "instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 3
}

variable "instance_name" {
  description = "Name of EC2 instance"
  type        = string
  default     = "terraform-workshop-web-multiple"
}

variable "instance_type" {
  description = "Type of instance to start. Updates to this field will trigger a stop/start of the EC2 instance"
  type        = string
  default     = "t3.small"
}

variable "instance_key_name" {
  description = "Name of a keypair to associate with the instance"
  type        = string
}