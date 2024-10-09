resource "aws_iam_user" "terraform_workshop" {
  name          = "Terraform-Workshop-User"
  force_destroy = true
}

resource "aws_iam_user_policy_attachment" "terraform_workshop_admin" {
  user       = aws_iam_user.terraform_workshop.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_user_login_profile" "terraform_workshop" {
  user = aws_iam_user.terraform_workshop.name
}

resource "aws_secretsmanager_secret" "terraform_workshop_user_password" {
  name                    = "terraform_workshop_user_password"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "terraform_workshop_user_password" {
  secret_id     = aws_secretsmanager_secret.terraform_workshop_user_password.id
  secret_string = aws_iam_user_login_profile.terraform_workshop.password
}

resource "aws_iam_access_key" "terraform_workshop" {
  user = aws_iam_user.terraform_workshop.name
}

resource "aws_secretsmanager_secret" "terraform_workshop_user_access_key" {
  name                    = "terraform_workshop_user_access_key"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "terraform_workshop_user_access_key" {
  secret_id = aws_secretsmanager_secret.terraform_workshop_user_access_key.id
  secret_string = jsonencode({
    access_key        = aws_iam_access_key.terraform_workshop.id
    secret_access_key = aws_iam_access_key.terraform_workshop.secret
  })
}