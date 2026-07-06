locals {
  alb_sg_id = data.aws_ssm_parameter.alb_sg_id.value
  frontend_sg_id = data.aws_ssm_parameter.frontend_sg_id.value
  backend_sg_id = data.aws_ssm_parameter.backend_sg_id.value
  public_subnets = split(",", data.aws_ssm_parameter.public_subnets_id.value)
  tg_frontend = data.aws_ssm_parameter.tg_frontend.value
  tg_backend = data.aws_ssm_parameter.tg_backend.value
}