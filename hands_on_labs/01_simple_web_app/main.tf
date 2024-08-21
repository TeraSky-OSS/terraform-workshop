
data "aws_ami" "nginx" {
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

data "aws_subnet" "selected" {
  filter {
    name   = "tag:Name"
    values = ["test-subnet-public1-us-east-1a"]
  }
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.nginx.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_current.id, data.aws_security_group.default.id]
  subnet_id              = data.aws_subnet.selected.id

  associate_public_ip_address = true

  tags = { Name = var.instance_name }
}