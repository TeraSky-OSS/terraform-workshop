variable "aws_region" {
  type        = string
  description = "Name of AWS region"
  default     = "us-east-1"
}

variable "ami_name_filters" {
  type        = list(string)
  description = "Name filter for searching AMI"
  default     = ["bitnami-nginx-1.27.0-0-linux-debian-12-x86_64-hvm-ebs-nami"]
}

variable "ami_owners" {
  type        = list(string)
  description = "List of AMI owners to limit search. At least 1 value must be specified. Valid values: an AWS account ID, self (the current account), or an AWS owner alias (e.g. amazon, aws-marketplace, microsoft)"
  default     = ["979382823631"]
}

variable "instance_count" {
  type        = number
  description = "Number of instances to create"
  default     = 3
}

variable "instance_name" {
  type        = string
  description = "Name of EC2 instance"
  default     = "terraform-workshop-web-modules"
}

variable "instance_type" {
  type        = string
  description = "Type of instance to start. Updates to this field will trigger a stop/start of the EC2 instance"
  default     = "t3.small"
}

variable "instance_key_name" {
  type        = string
  description = "Name of a keypair to associate with the instance"
}