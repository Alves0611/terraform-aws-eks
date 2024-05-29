variable "service_name" {
  type        = string
  description = "The name of the service for which the EKS cluster is being provisioned"
}

variable "public_subnet_1a" {
  type        = string
  description = "The ID of the public subnet in availability zone 1a"
}

variable "public_subnet_1b" {
  type        = string
  description = "The ID of the public subnet in availability zone 1b"
}
