variable "aws_region" {
  type        = string
  description = "Name of AWS region"
  default     = "us-east-1"
}

variable "aws_profile" {
  type        = string
  description = "Name of AWS profile"
  default     = "default"
}

variable "ami_name_filters" {
  type        = list(string)
  description = "Name filter for searching AMI"
}

variable "ami_owners" {
  type        = list(string)
  description = "List of AMI owners to limit search. At least 1 value must be specified. Valid values: an AWS account ID, self (the current account), or an AWS owner alias (e.g. amazon, aws-marketplace, microsoft)"
}

variable "instance_name" {
  type        = string
  description = "Name of EC2 instance"
  default     = ""
}

variable "instance_type" {
  type        = string
  description = "Type of instance to start. Updates to this field will trigger a stop/start of the EC2 instance"
  default     = "t3.micro"
}

variable "tags" {
  type        = map(string)
  description = "Map of tags to apply to resources"
  default = {
    Terraform = "True"
  }
}