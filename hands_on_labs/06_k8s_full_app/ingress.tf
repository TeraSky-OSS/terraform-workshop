resource "kubernetes_ingress_v1" "ingress_2048" {
  metadata {
    name      = "ingress-2048"
    namespace = kubernetes_namespace.game_2048.metadata[0].name

    annotations = {
      "alb.ingress.kubernetes.io/scheme"      = "internet-facing"
      "alb.ingress.kubernetes.io/target-type" = "ip"
    }
  }

  wait_for_load_balancer = true

  spec {
    ingress_class_name = "alb"

    rule {
      http {
        path {
          path      = "/"
          path_type = "Prefix"

          backend {
            service {
              name = kubernetes_service_v1.service_2048.metadata[0].name

              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}