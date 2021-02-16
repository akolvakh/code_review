# Networking Terraform Module for Zytara #

This Terraform module creates the base networking infrastructure on AWS for Zytara App.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name      | Version |
| --------- | ------- |
| terraform | >= 0.13 |

## Providers

| Name | Version |
| ---- | ------- |
| aws  | n/a     |

## Inputs

| Name                                             | Description                                                        | Type   | Default | Required |
| ------------------------------------------------ | ------------------------------------------------------------------ | ------ | ------- | :------: |
| app                                              | App name                   | `string` | "zytara"     |   yes    |
| env                                     | Environment                                   | `string`  | "dev"     |   yes    |
| vpc\_cidr\_block | The CIDR block for the VPC | `string` | "10.0.0.0/16"     |   yes    |
| vpc\_instance\_tenancy  | A tenancy option for instances launched into the VPC. Default is default, which makes your instances shared on the host. Using either of the other options (dedicated or host) costs at least $2/hr  | `string` | "default"     |   yes    |
| vpc\_enable\_dns_support                                      | A boolean flag to enable/disable DNS support in the VPC                                          | `bool` | `true` |    no    |
| vpc\_enable\_dns\_hostnames                                 | A boolean flag to enable/disable DNS hostnames in the VPC                                                 | `bool`  | `false`     |   no    |
| vpc\_enable\_classiclink                                 | A boolean flag to enable/disable ClassicLink for the VPC. Only valid in regions and accounts that support EC2 Classic. See the ClassicLink documentation for more information                                               | `bool`  | `false`     |   no    |
| vpc\_enable\_classiclink\_dns\_support                                 | A boolean flag to enable/disable ClassicLink DNS Support for the VPC. Only valid in regions and accounts that support EC2 Classic                                                 | `bool`  | `false`     |   no    |
| vpc\_assign\_generated\_ipv6\_cidr\_block                                 | Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block                                                 | `bool`  | `false`     |   no    |
| vpc\_tags                                 | A map of tags to assign to the resource                                                 | `map(string)`  |   n/a   |   no    |
| subnet\_cidr\_block                                 | The CIDR block for the subnet                                                 | `string`  | n/a     |   yes    |
| subnet\_availability\_zones                                 | The AZ for the subnet                                                 | `list(any)`  | n/a     |   no    |
| subnet\_availability\_zones\_id                                 | The AZ for the subnet                                                 | `list(any)`  | n/a     |   no    |
| subnet\_customer\_owned\_ipv4\_pool                                 | The customer owned IPv4 address pool. Typically used with the map_customer_owned_ip_on_launch argument. The outpost_arn argument must be specified when configured                                                 | `string`  | n/a     |   no    |
| subnet\_ipv6\_cidr\_block                                 | The IPv6 network range for the subnet, in CIDR notation. The subnet size must use a /64 prefix length                                                 | `string`  | n/a     |   no    |
| subnet\_map\_customer\_owned\_ip\_on\_launch                                 | Specify true to indicate that network interfaces created in the subnet should be assigned a customer owned IP address. The customer_owned_ipv4_pool and outpost_arn arguments must be specified when set to true                                                 | `bool`  | `false`     |   no    |
| subnet\_map\_public\_ip\_on\_launch                                 | Specify true to indicate that instances launched into the subnet should be assigned a public IP address                                                 | `bool`  | `false`     |   no    |
| subnet\_outpost\_arn                                 | The Amazon Resource Name (ARN) of the Outpost                                                 | `string`  | n/a     |   no    |
| subnet\_assign\_ipv6\_address\_on\_creation                                 | Specify true to indicate that network interfaces created in the specified subnet should be assigned an IPv6 address                                                 | `bool`  | `false`     |   no    |
| subnet\_tags                                 | A map of tags to assign to the resource                                                 | `map(string)`  | n/a     |   no    |
| security\_group\_tags                                 | A map of tags to assign to the resource                                                 | `map(string)`  | n/a     |   no    |
| security\_group\_name                                 | The name of the security group. If omitted, Terraform will assign a random, unique name                                                 | `string`  | "zytara-security-group"     |   no    |
| security\_group\_name\_prefix                                 | Creates a unique name beginning with the specified prefix. Conflicts with name                                                 | `string`  | "zt"     |   no    |
| security\_group\_description                                 | The security group description. Defaults to 'Managed by Terraform'. Cannot be empty. NOTE: This field maps to the AWS GroupDescription attribute, for which there is no Update API. If you'd like to classify your security groups in a way that can be updated, use tags                                                 | `string`  | "default description"     |   no    |
| security\_group\_revoke\_rules\_on\_delete                                 | Instruct Terraform to revoke all of the Security Groups attached ingress and egress rules before deleting the rule itself. This is normally not needed, however certain AWS services such as Elastic Map Reduce may automatically add required rules to security groups used with the service, and those rules may contain a cyclic dependency that prevent the security groups from being destroyed without removing the dependency first                                                 | `bool`  | `false`     |   no    |
| ingress\_from\_port                                 | The start port (or ICMP type number if protocol is 'icmp' or 'icmpv6')                                                 | `number`  | 22     |   yes    |
| ingress\_to\_port                                 | The end range port (or ICMP code if protocol is 'icmp')                                                 | `number`  | 22     |   yes    |
| ingress\_protocol                                 | The protocol. If you select a protocol of '-1' (semantically equivalent to 'all', which is not a valid value here), you must specify a 'from_port' and 'to_port' equal to 0. The supported values are defined in the 'IpProtocol' argument on the IpPermission API reference. This argument is normalized to a lowercase value to match the AWS API requirement when using with Terraform 0.12.x and above, please make sure that the value of the protocol is specified as lowercase when using with older version of Terraform to avoid an issue during upgrade                                                 | `string`  | "tcp"     |   yes    |
| ingress\_cidr\_block                                 | List of CIDR blocks                                                 | `list(any)`  | n/a     |   no    |
| ingress\_ipv6\_cidr\_blocks                                 | List of IPv6 CIDR blocks                                                 | `list(any)`  | n/a     |   no    |
| ingress\_prefix\_list\_ids                                 | List of Prefix List IDs                                                 | `list(any)`  | n/a     |   no    |
| ingress\_security\_groups                                 | List of security group Group Names if using EC2-Classic, or Group IDs if using a VPC                                                 | `list(any)`  | n/a     |   no    |
| ingress\_self                                 | If true, the security group itself will be added as a source to this ingress rule                                                 | `bool`  | `false`     |   no    |
| ingress\_description                                 | Description of this ingress rule                                                 | `string`  | "ingress description"     |   no    |
| egress\_from\_port                                 | The start port (or ICMP type number if protocol is 'icmp' or 'icmpv6')                                                 | `number`  | 22     |   yes    |
| egress\_to\_port                                 | The end range port (or ICMP code if protocol is 'icmp')                                                 | `number`  | 22     |   yes    |
| egress\_protocol                                 | The protocol. If you select a protocol of '-1' (semantically equivalent to 'all', which is not a valid value here), you must specify a 'from_port' and 'to_port' equal to 0. The supported values are defined in the 'IpProtocol' argument on the IpPermission API reference. This argument is normalized to a lowercase value to match the AWS API requirement when using with Terraform 0.12.x and above, please make sure that the value of the protocol is specified as lowercase when using with older version of Terraform to avoid an issue during upgrade                                                 | `string`  | "tcp"     |   yes    |
| egress\_cidr\_block                                 | List of CIDR blocks                                                 | `list(any)`  | n/a     |   no    |
| egress\_ipv6\_cidr\_blocks                                 | List of IPv6 CIDR blocks                                                 | `list(any)`  | n/a     |   no    |
| egress\_prefix\_list\_ids                                 | List of Prefix List IDs                                                 | `list(any)`  | n/a     |   no    |
| egress\_security\_groups                                 | List of security group Group Names if using EC2-Classic, or Group IDs if using a VPC                                                 | `list(any)`  | n/a     |   no    |
| egress\_self                                 | If true, the security group itself will be added as a source to this egress rule                                                 | `bool`  | `false`     |   no    |
| egress\_description                                 | Description of this egress rule                                                 | `string`  | "egress description"     |   no    |

## Outputs

| Name                               | Description                                                                                            |
| ---------------------------------- | ------------------------------------------------------------------------------------------------------ |
| vpc\_id                | The ID of the VPC                                                             |
| vpc\_cidr\_block              | The CIDR block of the VPC                                                                   |
| availability\_zones                       | List of availability zones used by subnets |
| private\_subnets\_ids              | List with the Private Subnets IDs                                                                      |
| public\_subnets\_ids | List with the Public Subnets IDs                                                         |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->