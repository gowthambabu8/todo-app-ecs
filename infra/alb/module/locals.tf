locals {
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  public_subnets = split(",", data.aws_ssm_parameter.public_subnets_id.value)
  alb_sg_id = data.aws_ssm_parameter.alb_sg_id.value
}