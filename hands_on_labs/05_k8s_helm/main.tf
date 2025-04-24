resource "helm_release" "nginx" {
  name       = "nginx"
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "nginx"

  values = [
    file("${path.module}/nginx-values.yaml")
  ]
}