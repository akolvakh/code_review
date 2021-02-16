#------------------------------------------------------------------------------
# VPC
#------------------------------------------------------------------------------
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

output "availability_zones" {
  description = "List of availability zones used by subnets"
  value       = var.subnet_availability_zones
}

#------------------------------------------------------------------------------
# AWS Subnets - Private
#------------------------------------------------------------------------------
output "private_subnets_ids" {
  description = "List with the Private Subnets IDs"
  value       = aws_subnet.private.*.id
}

#------------------------------------------------------------------------------
# AWS Subnets - Public
#------------------------------------------------------------------------------
output "public_subnets_ids" {
  description = "List with the Public Subnets IDs"
  value       = aws_subnet.public.*.id
}