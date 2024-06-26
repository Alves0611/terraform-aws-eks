variable "service_name" {
  type        = string
  description = "The service name identifier"
}

variable "cluster_name" {
  type        = string
  description = "EKS cluster name to create MNG"
}

variable "subnet_private_1a" {
  type        = string
  description = "Subnet ID from AZ 1a"
}

variable "subnet_private_1b" {
  type        = string
  description = "Subnet ID from AZ 1b"
}

variable "subnet_private_1c" {
  type        = string
  description = "Subnet ID from AZ 1c"
}