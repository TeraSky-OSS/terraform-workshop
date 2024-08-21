data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["test-vpc"]
  }
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = data.aws_vpc.selected.id
}

data "http" "myip" {
  url = "http://icanhazip.com"
}

resource "aws_security_group" "allow_current" {
  name        = "terraform-workshop"
  description = "Allow all traffic from my IP"
  vpc_id      = data.aws_vpc.selected.id

  ingress {
    description = "All from current IP"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = { Name = "terraform-workshop" }
}