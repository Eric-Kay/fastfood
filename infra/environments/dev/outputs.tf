output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "ecr_repository_urls" {
  value = module.ecr.repository_urls
}

output "ingress_namespace" {
  value = module.ingress.ingress_namespace
}

output "monitoring_namespace" {
  value = module.monitoring.monitoring_namespace
}