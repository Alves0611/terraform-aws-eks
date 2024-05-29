variable "service_name" {
  type        = string
  description = "Project name to be used to name the resources (Name tag)"
}

variable "oidc" {
  type        = string
  description = "HTTPS URL from OIDC provider of the EKS cluster"
}

variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}