output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = [for subnet in aws_subnet.this : subnet.id if can(regex(".*\\bpublic\\b.*", subnet.tags["Name"]))]
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = [for subnet in aws_subnet.this : subnet.id if can(regex(".*\\bprivate\\b.*", subnet.tags["Name"]))]
}

output "nat_gateway_ids" {
  description = "The IDs of the NAT Gateways"
  value       = aws_nat_gateway.this[*].id
}

output "eip_ids" {
  description = "The IDs of the Elastic IPs"
  value       = aws_eip.nat[*].id
}


output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.this.id
}

output "vpc" {
  value = aws.vpc.eks_vpc.id
}