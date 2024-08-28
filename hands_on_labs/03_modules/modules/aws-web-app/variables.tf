variable "vpc_name" {
  description = "Name of VPC"
  type        = string
}

variable "selected_subnet_tier" {
  description = "Tier of subnet to use"
  type        = string
}

variable "ami_name_filters" {
  description = "Name filter for searching AMI"
  type        = list(string)
}

variable "ami_owners" {
  description = "List of AMI owners to limit search. At least 1 value must be specified. Valid values: an AWS account ID, self (the current account), or an AWS owner alias (e.g. amazon, aws-marketplace, microsoft)"
  type        = list(string)
}

variable "instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 1
}

variable "instance_name" {
  description = "Name of EC2 instance"
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "Type of instance to start. Updates to this field will trigger a stop/start of the EC2 instance"
  type        = string
  default     = "t3.micro"
}

variable "instance_key_name" {
  description = "Name of a keypair to associate with the instance"
  type        = string
}