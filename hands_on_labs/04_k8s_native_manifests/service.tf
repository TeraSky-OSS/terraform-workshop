resource "kubernetes_service_v1" "service_2048" {
  metadata {
    name      = "service-2048"
    namespace = kubernetes_namespace.game_2048.metadata[0].name
  }

  spec {
    port {
      port        = 80
      target_port = 80
      protocol    = "TCP"
    }

    selector = {
      "app.kubernetes.io/name" = "app-2048"
    }

    type = "NodePort"
  }
}