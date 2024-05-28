variable "aws_region" {
  type        = string
  description = "The region to deploy to"
}

variable "service_name" {
  type        = string
  description = "The service name identifier"
}

variable "cidr_block" {
  type        = string
  description = "Networking CIDR block to be used for the VPC"
}

variable "create_nat_gateway" {
  type        = bool
  description = "Whether to create NAT Gateway"
}

variable "nat_gateway_per_az" {
  type        = bool
  description = "Whether to create a NAT Gateway in each availability zone"
}
