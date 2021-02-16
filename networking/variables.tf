#------------------------------------------------------------------------------
# General variables
#------------------------------------------------------------------------------
variable "app" {
    description ="(Required) App name."
    type        = string
    default     = "zytara"
}

variable "env" {
    description = "(Required) Environment."
    type        = string
    default     = "dev"
}

#------------------------------------------------------------------------------
# VPC variables
#------------------------------------------------------------------------------
variable "vpc_cidr_block" {
    description = "(Required) The CIDR block for the VPC."
    type        = string
    default     = "10.0.0.0/16"
}

# variable "vpc_block_part" {}

variable "vpc_instance_tenancy" {
    description = "(Optional) A tenancy option for instances launched into the VPC. Default is default, which makes your instances shared on the host. Using either of the other options (dedicated or host) costs at least $2/hr."
    type        = string
    default     = "default"
}

variable "vpc_enable_dns_support" {
    description = "(Optional) A boolean flag to enable/disable DNS support in the VPC. Defaults true."
    type        = bool
    default     = true
}

variable "vpc_enable_dns_hostnames" {
    description = "(Optional) A boolean flag to enable/disable DNS hostnames in the VPC. Defaults false."
    type        = bool
    default     = false
}

variable "vpc_enable_classiclink" {
    description = "(Optional) A boolean flag to enable/disable ClassicLink for the VPC. Only valid in regions and accounts that support EC2 Classic. See the ClassicLink documentation for more information. Defaults false."
    type        = bool
    default     = false
}

variable "vpc_enable_classiclink_dns_support" {
    description = "(Optional) A boolean flag to enable/disable ClassicLink DNS Support for the VPC. Only valid in regions and accounts that support EC2 Classic."
    type        = bool
    default     = false
}

variable "vpc_assign_generated_ipv6_cidr_block" {
    description = "(Optional) Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block. Default is false."
    type        = bool
    default     = false
}

variable "vpc_tags" {
  description = "(Optional) A map of tags to assign to the resource."
  type        = map(string)
  default     = {
      Name        = "zytara-vpc",
      Environment = "dev",
      App         = "zytara"
  }
}

#------------------------------------------------------------------------------
# Subnet variables
#------------------------------------------------------------------------------
variable "subnet_cidr_block" {
    description = "(Required) The CIDR block for the subnet."
    type        = string
    # default     = "10.0.0.0/16"
}

variable "subnet_availability_zones" {
  description = "(Optional) The AZ for the subnet."
  type          = list(any)
  default       = ["zone-1","zone-2"]
}

variable "subnet_availability_zones_id" {
    description = "(Optional) The AZ for the subnet."
    type        = list(any)
    default     = ["subnet-xxxx1","subnet-xxxx2"]
}

variable "subnet_customer_owned_ipv4_pool" {
    description = "(Optional) The customer owned IPv4 address pool. Typically used with the map_customer_owned_ip_on_launch argument. The outpost_arn argument must be specified when configured."
    type        = string
    # default     =
}

variable "subnet_ipv6_cidr_block" {
    description = "(Optional) The IPv6 network range for the subnet, in CIDR notation. The subnet size must use a /64 prefix length."
    type        = string
    # default     =
}

variable "subnet_map_customer_owned_ip_on_launch" {
    description = "(Optional) Specify true to indicate that network interfaces created in the subnet should be assigned a customer owned IP address. The customer_owned_ipv4_pool and outpost_arn arguments must be specified when set to true. Default is false."
    type        = bool
    default     = false
}

variable "subnet_map_public_ip_on_launch" {
    description = "(Optional) Specify true to indicate that instances launched into the subnet should be assigned a public IP address. Default is false."
    type        = bool
    default     = false
}

variable "subnet_outpost_arn" {
    description = "(Optional) The Amazon Resource Name (ARN) of the Outpost."
    type        = string
    # default     =
}

variable "subnet_assign_ipv6_address_on_creation" {
    description = "(Optional) Specify true to indicate that network interfaces created in the specified subnet should be assigned an IPv6 address. Default is false"
    type        = bool
    default     = false
}

variable "subnet_tags" {
  description = "(Optional) A map of tags to assign to the resource."
  type        = map(string)
  default     = {
      Name        = "zytara-subnet",
      Environment = "dev",
      App         = "zytara"
  }
}

#------------------------------------------------------------------------------
# Security group variables
#------------------------------------------------------------------------------
variable "security_group_tags" {
  description = "(Optional) A map of tags to assign to the resource."
  type        = map(string)
  default     = {
      Name        = "zytara-security-group",
      Environment = "dev",
      App         = "zytara"
  }
}

variable "security_group_name" {
    description = "(Optional, Forces new resource) The name of the security group. If omitted, Terraform will assign a random, unique name"
    type        = string
    default     = "zytara-security-group"
}

variable "security_group_name_prefix" {
    description = "(Optional, Forces new resource) Creates a unique name beginning with the specified prefix. Conflicts with name."
    type        = string
    default     = "zt"
}

variable "security_group_description" {
    description = "(Optional, Forces new resource) The security group description. Defaults to 'Managed by Terraform'. Cannot be empty. NOTE: This field maps to the AWS GroupDescription attribute, for which there is no Update API. If you'd like to classify your security groups in a way that can be updated, use tags."
    type        = string
    default     = "default description"
}

variable "security_group_revoke_rules_on_delete" {
    description = "(Optional) Instruct Terraform to revoke all of the Security Groups attached ingress and egress rules before deleting the rule itself. This is normally not needed, however certain AWS services such as Elastic Map Reduce may automatically add required rules to security groups used with the service, and those rules may contain a cyclic dependency that prevent the security groups from being destroyed without removing the dependency first. Default false."
    type        = bool
    default     = false
}

#------------------------------------------------------------------------------
# Security group - ingress - variables
#------------------------------------------------------------------------------
variable "ingress_from_port" {
    description = "(Required) The start port (or ICMP type number if protocol is 'icmp' or 'icmpv6')"
    type        = number
    default     = 22
}

variable "ingress_to_port" {
    description = "(Required) The end range port (or ICMP code if protocol is 'icmp')."
    type        = number
    default     = 22
}

variable "ingress_protocol" {
    description = "(Required) The protocol. If you select a protocol of '-1' (semantically equivalent to 'all', which is not a valid value here), you must specify a 'from_port' and 'to_port' equal to 0. The supported values are defined in the 'IpProtocol' argument on the IpPermission API reference. This argument is normalized to a lowercase value to match the AWS API requirement when using with Terraform 0.12.x and above, please make sure that the value of the protocol is specified as lowercase when using with older version of Terraform to avoid an issue during upgrade."
    type        = string
    default     = "tcp"
}

variable "ingress_cidr_block" {
    description = "(Optional) List of CIDR blocks."
    type        = list(any)
    default     = ["cb-1","cb-2"]
}

variable "ingress_ipv6_cidr_blocks" {
    description = "(Optional) List of IPv6 CIDR blocks."
    type        = list(any)
    default     = ["cb-1","cb-2"]
}

variable "ingress_prefix_list_ids" {
    description = "(Optional) List of Prefix List IDs."
    type        = list(any)
    default     = ["cb-1","cb-2"]
}

variable "ingress_security_groups" {
    description = "(Optional) List of security group Group Names if using EC2-Classic, or Group IDs if using a VPC."
    type        = list(any)
    default     = ["sg-1","sg-2"]
}

variable "ingress_self" {
    description = "(Optional) If true, the security group itself will be added as a source to this ingress rule."
    type        = bool
    default     = false
}

variable "ingress_description" {
    description = "(Optional) Description of this ingress rule."
    type        = string
    default     = "ingress description"
}

#------------------------------------------------------------------------------
# Security group - egress - variables
#------------------------------------------------------------------------------
variable "egress_from_port" {
    description = "(Required) The start port (or ICMP type number if protocol is 'icmp' or 'icmpv6')"
    type        = number
    # default     =
}

variable "egress_to_port" {
    description = "(Required) The end range port (or ICMP code if protocol is 'icmp')."
    type        = number
    # default     =
}

variable "egress_protocol" {
    description = "(Required) The protocol. If you select a protocol of '-1' (semantically equivalent to 'all', which is not a valid value here), you must specify a 'from_port' and 'to_port' equal to 0. The supported values are defined in the 'IpProtocol' argument on the IpPermission API reference. This argument is normalized to a lowercase value to match the AWS API requirement when using with Terraform 0.12.x and above, please make sure that the value of the protocol is specified as lowercase when using with older version of Terraform to avoid an issue during upgrade."
    type        = string
    default     = "-1"
}

variable "egress_cidr_block" {
    description = "(Optional) List of CIDR blocks."
    type        = list(any)
    default     = ["cb-1","cb-2"]
}

variable "egress_ipv6_cidr_blocks" {
    description = "(Optional) List of IPv6 CIDR blocks."
    type        = list(any)
    default     = ["cb-1","cb-2"]
}

variable "egress_prefix_list_ids" {
    description = "(Optional) List of Prefix List IDs."
    type        = list(any)
    default     = ["cb-1","cb-2"]
}

variable "egress_security_groups" {
    description = "(Optional) List of security group Group Names if using EC2-Classic, or Group IDs if using a VPC."
    type        = list(any)
    default     = ["cb-1","cb-2"]
}

variable "egress_self" {
    description = "(Optional) If true, the security group itself will be added as a source to this egress rule."
    type        = bool
    default     = false
}

variable "egress_description" {
    description = "(Optional) Description of this egress rule."
    type        = string
    default     = "egress description"
}