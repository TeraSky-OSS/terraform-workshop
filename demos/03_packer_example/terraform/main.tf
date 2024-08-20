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

resource "aws_instance" "web" {
  ami                    = data.aws_ami.packer.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_current.id, data.aws_security_group.default.id]

  tags = merge(
    {
      Name = var.instance_name
    },
    var.tags
  )
}