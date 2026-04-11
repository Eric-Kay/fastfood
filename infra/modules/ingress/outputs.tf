output "ingress_namespace" {
  value = helm_release.ingress_nginx.namespace
}

output "ingress_release_name" {
  value = helm_release.ingress_nginx.name
}