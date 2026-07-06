data "aws_ssm_parameter" "alb_sg_id" {
  name = "/${var.project-name}/${var.env}/alb_sg_id"
}

data "aws_ssm_parameter" "frontend_sg_id" {
  name = "/${var.project-name}/${var.env}/frontend_sg_id"
}

data "aws_ssm_parameter" "backend_sg_id" {
  name = "/${var.project-name}/${var.env}/backend_sg_id"
}

data "aws_ssm_parameter" "public_subnets_id"{
    name = "/${var.project-name}/${var.env}/public_subnet"
}

data "aws_ssm_parameter" "tg_frontend" {
    name = "/${var.project-name}/${var.env}/tg_frontend"
}

data "aws_ssm_parameter" "tg_backend" {
    name = "/${var.project-name}/${var.env}/tg_backend"
}