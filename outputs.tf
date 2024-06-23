output "cluster_name" {
  description = "The name of the EKS cluster"
  value       = module.eks_cluster.cluster_name
}

output "certificate_authority" {
  description = "The certificate authority data for the EKS cluster"
  value       = module.eks_cluster.certificate_authority
}

output "endpoint" {
  description = "The endpoint for the EKS cluster"
  value       = module.eks_cluster.endpoint
}
