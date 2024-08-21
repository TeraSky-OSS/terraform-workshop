locals {
  max_subnet_count         = max(var.public_subnet_count, var.private_subnet_count)
  availability_zones_names = slice(data.aws_availability_zones.available.names, 0, local.max_subnet_count)
  availability_zones_ids   = slice(data.aws_availability_zones.available.zone_ids, 0, local.max_subnet_count)

  public_subnets  = [for index in range(var.public_subnet_count) : cidrsubnet(var.vpc_cidr, 8, index + var.public_subnet_network_start)]
  private_subnets = [for index in range(var.private_subnet_count) : cidrsubnet(var.vpc_cidr, 4, index + 1)]
}


data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.13"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs                  = local.availability_zones_names
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  create_igw         = var.create_igw
  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = var.single_nat_gateway

  public_subnets          = local.public_subnets
  public_subnet_suffix    = var.public_subnet_suffix
  public_subnet_names     = [for az_id in local.availability_zones_ids : "${var.vpc_name}-${var.public_subnet_suffix}-${az_id}"]
  public_subnet_tags      = var.public_subnet_tags
  public_route_table_tags = var.public_route_table_tags
  map_public_ip_on_launch = var.map_public_ip_on_launch

  private_subnets          = local.private_subnets
  private_subnet_suffix    = var.private_subnet_suffix
  private_subnet_names     = [for az_id in local.availability_zones_ids : "${var.vpc_name}-${var.private_subnet_suffix}-${az_id}"]
  private_subnet_tags      = var.private_subnet_tags
  private_route_table_tags = var.private_route_table_tags
}
