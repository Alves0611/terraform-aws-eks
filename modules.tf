module "eks_network" {
  source = "./modules/network"

  aws_region         = var.aws_region
  cidr_block         = var.cidr_block
  service_name       = var.service_name
  create_nat_gateway = false
  nat_gateway_per_az = false
}
