data "aws_ami" "packer" {
  most_recent = true

  filter {
    name   = "name"
    values = var.ami_name_filters
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = var.ami_owners
}

data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnets" "selected" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }

  tags = {
    Tier = var.selected_subnet_tier
  }
}
resource "aws_instance" "web" {
  ami                    = data.aws_ami.packer.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_current.id, data.aws_security_group.default.id]
  subnet_id              = data.aws_subnets.selected.ids[0]

  associate_public_ip_address = true

  tags = {Name = var.instance_name}
}