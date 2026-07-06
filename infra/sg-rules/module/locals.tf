locals {
  alb_sg_id = data.aws_ssm_parameter.alb_sg_id.value
  frontend_sg_id = data.aws_ssm_parameter.frontend_sg_id.value
  backend_sg_id = data.aws_ssm_parameter.backend_sg_id.value

  sg_id_list = [
    local.alb_sg_id,
    local.frontend_sg_id,
    local.backend_sg_id
  ]
  
  # ports and services
  common_port = 22
  http_port = 80
  https_port = 443
  backend_service_port = 8000

}