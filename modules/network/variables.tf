variable "aws_region" {
  type        = string
  description = "The region to deploy to"
  default = "us-east-1"
}

variable "service_name" {
  type        = string
  description = "The service name identifier"
  default = "eks"
}

variable "cidr_block" {
  type        = string
  description = "Networking CIDR block to be used for the VPC"
  default = "10.0.0.0/16"
}

