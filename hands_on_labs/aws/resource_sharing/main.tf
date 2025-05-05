# VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.vpc_name
  }
}

# Public Subnets
resource "aws_subnet" "public" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "${var.vpc_name}-public-${count.index + 1}"
    Tier = "public"
  }
}

# Private Subnets
resource "aws_subnet" "private" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index + length(var.availability_zones))
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "${var.vpc_name}-private-${count.index + 1}"
    Tier = "private"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

# NAT Gateway
resource "aws_nat_gateway" "main" {
  count             = length(var.availability_zones)
  subnet_id         = aws_subnet.public[count.index].id
  connectivity_type = "private"

  tags = {
    Name = "${var.vpc_name}-nat-${count.index + 1}"
  }

  depends_on = [aws_internet_gateway.main]
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "${var.vpc_name}-public-rt"
  }
}

# Public Route Table Associations
resource "aws_route_table_association" "public" {
  count          = length(var.availability_zones)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Private Route Table
resource "aws_route_table" "private" {
  count  = length(var.availability_zones)
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[count.index].id
  }

  tags = {
    Name = "${var.vpc_name}-private-rt-${count.index + 1}"
  }
}

# Private Route Table Associations
resource "aws_route_table_association" "private" {
  count          = length(var.availability_zones)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

# RAM Resource Share
resource "aws_ram_resource_share" "subnets" {
  count = length(var.ram_principals) > 0 ? 1 : 0

  name                      = "${var.vpc_name}-subnet-share"
  allow_external_principals = var.allow_external_principals

  tags = {
    Name = "${var.vpc_name}-subnet-share"
  }
}

# RAM Resource Association for Public Subnets
resource "aws_ram_resource_association" "public_subnets" {
  count = length(var.ram_principals) > 0 ? length(var.availability_zones) : 0

  resource_share_arn = aws_ram_resource_share.subnets[0].arn
  resource_arn       = aws_subnet.public[count.index].arn
}

# RAM Resource Association for Private Subnets
resource "aws_ram_resource_association" "private_subnets" {
  count = length(var.ram_principals) > 0 ? length(var.availability_zones) : 0

  resource_share_arn = aws_ram_resource_share.subnets[0].arn
  resource_arn       = aws_subnet.private[count.index].arn
}

# RAM Principal Association
resource "aws_ram_principal_association" "subnets" {
  count = length(var.ram_principals)

  resource_share_arn = aws_ram_resource_share.subnets[0].arn
  principal          = var.ram_principals[count.index]
}