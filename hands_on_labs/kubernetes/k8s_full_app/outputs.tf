output "game_2048_endpoint" {
  value = "http://${kubernetes_ingress_v1.ingress_2048.status.0.load_balancer.0.ingress.0.hostname}"
}