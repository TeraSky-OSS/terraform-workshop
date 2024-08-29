packer {
  required_plugins {
    amazon = {
      version = "~> 1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "vpc_name" {
  type    = string
  default = "terraform-workshop-vpc"
}

variable "selected_subnet_tier" {
  type    = string
  default = "public"
}

source "amazon-ebs" "ubuntu" {
  vpc_filter {
    filters = {
      "tag:Name" : var.vpc_name
    }
  }

  subnet_filter {
    filters = {
      "tag:Tier" : var.selected_subnet_tier
    }
    random = true
  }

  ami_name                    = "terraform-workshop-packer-nginx"
  instance_type               = "t2.micro"
  region                      = "us-east-1"
  associate_public_ip_address = true
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-noble-24.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}

build {
  name = "terraform-workshop-packer-nginx"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "shell" {
    inline = [
      "echo Installing NGINX",
      "sudo apt update",
      "sudo apt install -y nginx"
    ]
  }

  provisioner "shell" {
    inline = ["echo Placing custom index.html file"]
  }

  provisioner "file" {
    source      = "index.html"
    destination = "/tmp/index.html"
  }

  provisioner "shell" {
    inline = [
      "echo Moving file to correct location",
      "sudo mv /tmp/index.html /var/www/html/index.html"
    ]
  }
}