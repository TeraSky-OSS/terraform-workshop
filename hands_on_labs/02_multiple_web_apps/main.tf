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
  count = var.instance_count

  ami                    = data.aws_ami.nginx.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_current.id, data.aws_security_group.default.id]
  subnet_id              = data.aws_subnets.selected.ids[0]

  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              echo "<h1>This is server ${count.index}</h1>" > /opt/bitnami/nginx/html/index.html
              EOF
  
  user_data_replace_on_change = true

  tags = { Name = "${var.instance_name}-${count.index}" }
}

resource "aws_elb" "web" {
  name            = "terraform-workshop-web-elb"
  subnets         = aws_instance.web.*.subnet_id
  security_groups = [aws_security_group.allow_current.id, data.aws_security_group.default.id]
  instances       = aws_instance.web.*.id

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 15
    target              = "HTTP:80/"
    interval            = 30
  }
}