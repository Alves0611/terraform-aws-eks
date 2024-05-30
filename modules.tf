module "eks_network" {
  source = "./modules/network"

  aws_region   = var.aws_region
  cidr_block   = var.cidr_block
  service_name = var.service_name
}

module "eks_cluster" {
  source       = "./modules/cluster"
  service_name = var.service_name

  public_subnet_1a = module.eks_network.public_subnet_ids[0]
  public_subnet_1b = module.eks_network.public_subnet_ids[1]
  public_subnet_1c = module.eks_network.public_subnet_ids[2]
}

module "eks_managed_node_group" {
  source            = "./modules/managed-node-group"
  service_name      = var.service_name
  cluster_name      = module.eks_cluster.cluster_name
  subnet_private_1a = module.eks_network.private_subnet_ids[0]
  subnet_private_1b = module.eks_network.private_subnet_ids[1]
  subnet_private_1c = module.eks_network.private_subnet_ids[2]
}

module "eks_aws_load_balancer_controller" {
  source       = "./modules/aws-load-balancer-controller"
  service_name = var.service_name
  oidc         = module.eks_cluster.oidc
  cluster_name = module.eks_cluster.cluster_name
}