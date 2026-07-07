data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project-name}/${var.env}/vpc_id"
}

data "aws_ssm_parameter" "public_subnets_id"{
    name = "/${var.project-name}/${var.env}/public_subnet"
}

data "aws_ssm_parameter" "alb_sg_id" {
  name = "/${var.project-name}/${var.env}/alb_sg_id"
}