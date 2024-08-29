resource "kubernetes_namespace" "game_2048" {
  metadata {
    name = "game-2048"
  }
}