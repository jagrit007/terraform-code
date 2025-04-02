output "eks_endpoint" {
  value = module.eks.eks_endpoint
}

output "cluster" {
  value = module.eks.cluster_name
}

output "vpc_id" {
  value = module.vpc.vpc_id
}