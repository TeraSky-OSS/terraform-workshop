module "web" {
  source = "../modules/aws-web-app"

  ami_name_filters  = var.ami_name_filters
  ami_owners        = var.ami_owners
  instance_count    = var.instance_count
  instance_name     = var.instance_name
  instance_type     = var.instance_type
  instance_key_name = var.instance_key_name
  tags              = var.tags
}