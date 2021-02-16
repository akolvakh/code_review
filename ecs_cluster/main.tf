#------------------------------------------------------------------------------
# ECS
#------------------------------------------------------------------------------
resource "aws_ecs_cluster" "main" {
  name                  = var.ecs_name
  capacity_providers    = var.ecs_capacity_providers
  
  # tags                  = var.ecs_tags

  tags = {
    Name        = "${var.app}-${var.env}-ecs"
    Terraform   = true
    App         = "${var.app}"
    Environment = "${var.app}-${var.env}"
  }

  default_capacity_provider_strategy {
    capacity_provider   = var.dcps_capacity_provider
    weight              = var.dcps_weight
    base                = var.dcps_base
  }

  setting {
    name                = var.setting_name
    value               = var.setting_value
  }
}