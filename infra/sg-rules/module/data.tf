data "aws_ssm_parameter" "alb_sg_id" {
  name = "/${var.project}/${var.environment}/alb_sg_id"
}

data "aws_ssm_parameter" "frontend_sg_id" {
  name = "/${var.project}/${var.environment}/frontend_sg_id"
}

data "aws_ssm_parameter" "backend_sg_id" {
  name = "/${var.project}/${var.environment}/backend_sg_id"
}