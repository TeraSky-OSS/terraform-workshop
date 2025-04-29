resource "kubernetes_deployment_v1" "deployment_2048" {
  metadata {
    name      = "deployment-2048"
    namespace = kubernetes_namespace.game_2048.metadata[0].name
  }

  spec {
    replicas = 5

    selector {
      match_labels = {
        "app.kubernetes.io/name" = "app-2048"
      }
    }

    template {
      metadata {
        labels = {
          "app.kubernetes.io/name" = "app-2048"
        }
      }

      spec {
        service_account_name = kubernetes_service_account.demo.metadata[0].name

        container {
          image             = "public.ecr.aws/l6m2t8p7/docker-2048:latest"
          name              = "app-2048"
          image_pull_policy = "Always"

          port {
            container_port = 80
          }
        }
      }
    }
  }
}