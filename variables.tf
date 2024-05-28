variable "aws_region" {
  type        = string
  description = "The region to deploy to"
}

variable "service_name" {
  type        = string
  description = "The service name identifier"
  default     = "eks"
}

variable "cidr_block" {
  type        = string
  description = "Networking CIDR block to be used for the VPC"
}
