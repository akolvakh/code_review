#------------------------------------------------------------------------------
# VPC
#------------------------------------------------------------------------------
resource "aws_vpc" "main" {
  cidr_block                        = var.vpc_cidr_block
  enable_dns_hostnames              = var.vpc_enable_dns_hostnames
  enable_dns_support                = var.vpc_enable_dns_support
  instance_tenancy                  = var.vpc_instance_tenancy
  enable_classiclink                = var.vpc_enable_classiclink
  enable_classiclink_dns_support    = var.vpc_enable_classiclink_dns_support
  assign_generated_ipv6_cidr_block  = var.vpc_assign_generated_ipv6_cidr_block

#   tags                              = var.security_group_tags

  tags = {
    Name        = "${var.app}-${var.env}-vpc"
    Terraform   = true
    App         = "${var.app}"
    Environment = "${var.app}-${var.env}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

#------------------------------------------------------------------------------
# Subnets
#------------------------------------------------------------------------------
resource "aws_subnet" "public" {
  count                             = length(var.availability_zones)
  vpc_id                            = aws_vpc.main.id
  cidr_block                        = element(var.subnet_availability_zones_id, count.index)
  availability_zone                 = element(var.subnet_availability_zones, count.index)
  availability_zone_id              = var.subnet_availability_zones_id
  customer_owned_ipv4_pool          = var.subnet_customer_owned_ipv4_pool
  ipv6_cidr_block                   = var.subnet_ipv6_cidr_block
  map_customer_owned_ip_on_launch   = var.subnet_map_customer_owned_ip_on_launch
  map_public_ip_on_launch           = var.subnet_map_public_ip_on_launch
  outpost_arn                       = var.subnet_outpost_arn
  assign_ipv6_address_on_creation   = var.subnet_assign_ipv6_address_on_creation

#   tags                              = var.subnet_tags

  tags = {
    Name        = "${var.app}-${var.env}-public-subnet"
    Terraform   = true
    App         = "${var.app}"
    Environment = "${var.app}-${var.env}"
  }
}

resource "aws_subnet" "private" {
  count                             = length(var.availability_zones)
  vpc_id                            = aws_vpc.main.id
  cidr_block                        = element(var.subnet_availability_zones_id, count.index)
  availability_zone                 = element(var.subnet_availability_zones, count.index)
  availability_zone_id              = var.subnet_availability_zones_id
  customer_owned_ipv4_pool          = var.subnet_customer_owned_ipv4_pool
  ipv6_cidr_block                   = var.subnet_ipv6_cidr_block
  map_customer_owned_ip_on_launch   = var.subnet_map_customer_owned_ip_on_launch
  map_public_ip_on_launch           = var.subnet_map_public_ip_on_launch
  outpost_arn                       = var.subnet_outpost_arn
  assign_ipv6_address_on_creation   = var.subnet_assign_ipv6_address_on_creation

#   tags                              = var.subnet_tags
  
  tags = {
    Name        = "${var.app}-${var.env}-private-subnet"
    Terraform   = true
    App         = "${var.app}"
    Environment = "${var.app}-${var.env}"
  }
}

#------------------------------------------------------------------------------
# Security group
#------------------------------------------------------------------------------
resource "aws_security_group" "default" {
  vpc_id                    = aws_vpc.main.id
  name                      = var.security_group_name
  name_prefix               = var.security_group_name_prefix
  description               = var.security_group_description
  revoke_rules_on_delete    = var.security_group_revoke_rules_on_delete

#   tags                      = var.security_group_tags

  tags = {
    Name        = "${var.app}-${var.env}-sg"
    Terraform   = true
    App         = "${var.app}"
    Environment = "${var.app}-${var.env}"
  }

  ingress {
    from_port               = var.ingress_from_port
    to_port                 = var.ingress_to_port
    protocol                = var.ingress_protocol
    cidr_blocks             = var.ingress_cidr_block
    ipv6_cidr_blocks        = var.ingress_ipv6_cidr_blocks
    prefix_list_ids         = var.ingress_prefix_list_ids
    security_groups         = var.ingress_security_groups
    self                    = var.ingress_self
    description             = var.ingress_description
  }

  egress {
    from_port               = var.egress_from_port
    to_port                 = var.egress_to_port
    protocol                = var.egress_protocol
    cidr_blocks             = var.egress_cidr_block
    ipv6_cidr_blocks        = var.egress_ipv6_cidr_blocks
    prefix_list_ids         = var.egress_prefix_list_ids
    security_groups         = var.egress_security_groups
    self                    = var.egress_self
    description             = var.egress_description
  }
}