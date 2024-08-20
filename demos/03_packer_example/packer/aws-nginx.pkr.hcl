packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  profile       = "terasky"
  ami_name      = "terraform-secure-workshop-packer-nginx"
  instance_type = "t2.micro"
  region        = "us-east-1"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-focal-20.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}

build {
  name    = "terraform-secure-workshop-packer-nginx"
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
    source = "index.html"
    destination = "/tmp/index.html"
  }

  provisioner "shell" {
    inline = [
      "echo Moving file to correct location",
      "sudo mv /tmp/index.html /var/www/html/index.html"
    ]
  }
}