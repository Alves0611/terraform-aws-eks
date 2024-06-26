variable "service_name" {
  type        = string
  description = "The name of the service for which the EKS cluster is being provisioned"
}

variable "vpc" {
  type        = string
  description = "VPC for SG"
}

variable "public_subnet" {
  type        = list(string)
  description = "Subnet for Bastion Host"
}

variable "private_subnet" {
  type        = list(string)
  description = "Subnet for MongoDB"
}

variable "cluster_sg" {
  type        = string
  description = "EKS Cluster Security Group"
}
