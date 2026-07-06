locals {
  common_tags = {
    Name = "${var.project}-${var.environment}"
    Project = var.project
    Environment = var.environment
    Terraform = true
  }

  sg_final_tags = merge(
    var.sg_tags,
    {
        Name = "${var.project}-${var.environment}-sg"
    },
    local.common_tags
  )

  vpc_id = data.aws_ssm_parameter.vpc_id.value
}