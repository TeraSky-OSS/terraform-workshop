output "release_output" {
  value = helm_release.nginx.metadata.0
}