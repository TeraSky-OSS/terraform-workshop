resource "kubernetes_service_account" "demo" {
  metadata {
    name      = "demo-service-account"
    namespace = kubernetes_namespace.game_2048.metadata[0].name
  }
}