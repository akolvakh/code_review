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
# ECS variables
#------------------------------------------------------------------------------
variable "ecs_name" {
    description = "(Required) The name of the cluster (up to 255 letters, numbers, hyphens, and underscores)"
    type        = string
    default     = "zytara"
}

variable "ecs_capacity_providers" {
    description = "(Optional) List of short names of one or more capacity providers to associate with the cluster. Valid values also include FARGATE and FARGATE_SPOT."
    type        = string
    default     = "FARGATE"
}

variable "ecs_tags" {
    description = "(Optional) Key-value map of resource tags."
    type        = map(string)
    default     = {
      Environment = "dev",
      App         = "zytara",
      Name        = "zytara-ecs"
  }
}


# variable "ecs_default_capacity_provider_strategy" {
#     description = "(Optional) The capacity provider strategy to use by default for the cluster. Can be one or more. Defined below."
#     # default     = 
# }

# variable "ecs_setting" {
#     description = "(Optional) Configuration block(s) with cluster settings. For example, this can be used to enable CloudWatch Container Insights for a cluster. Defined below."
#     # default     = 
# }

#------------------------------------------------------------------------------
# Setting variables
#------------------------------------------------------------------------------
variable "setting_name" {
    description = "(Required) Name of the setting to manage. Valid values: containerInsights."
    type        = string
    default     = "containerInsights"
}

variable "setting_value" {
    description = "(Required) The value to assign to the setting. Value values are enabled and disabled."
    type        = string
    default     = "disabled"
}

#------------------------------------------------------------------------------
# Dcps variables
#------------------------------------------------------------------------------
variable "dcps_capacity_provider" {
    description = "(Required) The short name of the capacity provider."
    type        = string
    default     = "FARGATE"
}

variable "dcps_weight" {
    description = "(Optional) The relative percentage of the total number of launched tasks that should use the specified capacity provider."
    type        = number
    # default     = 
}

variable "dcps_base" {
    description = "(Optional) The number of tasks, at a minimum, to run on the specified capacity provider. Only one capacity provider in a capacity provider strategy can have a base defined."
    type        = number
    # default     = 
}