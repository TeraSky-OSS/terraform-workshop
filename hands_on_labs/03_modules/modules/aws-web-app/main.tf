
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

resource "aws_instance" "web" {
  count = var.instance_count

  ami                    = data.aws_ami.nginx.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_current.id, data.aws_security_group.default.id]
  key_name               = var.instance_key_name

  provisioner "remote-exec" {
    connection {
      host        = self.public_ip
      user        = "bitnami"
      private_key = file("~/.ssh/id_rsa")
    }

    inline = [
      "echo \"<h1>This is server ${count.index}</h1>\" > /opt/bitnami/nginx/html/index.html"
    ]
  }

  tags = {Name = "${var.instance_name}-${count.index}"}
}

resource "aws_elb" "web" {
  name            = "web-elb"
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