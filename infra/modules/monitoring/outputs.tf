output "monitoring_namespace" {
  value = helm_release.kube_prometheus_stack.namespace
}

output "prometheus_release_name" {
  value = helm_release.kube_prometheus_stack.name
}

output "metrics_server_release_name" {
  value = helm_release.metrics_server.name
}