resource "kubernetes_persistent_volume_claim" "demo" {
  metadata {
    name      = "demo-pvc"
    namespace = kubernetes_namespace.game_2048.metadata[0].name
  }

  spec {
    access_modes = ["ReadWriteOnce"]

    resources {
      requests = {
        storage = "1Gi"
      }
    }

    storage_class_name = "gp3"
  }
}