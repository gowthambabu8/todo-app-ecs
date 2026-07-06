module "ecs" {
  source = "../../module"
  project-name = var.project-name
  env = var.env
  aws_region = var.aws_region
  backend_container_port = var.backend_container_port
  backend_cpu = var.backend_cpu
  backend_memory = var.backend_memory
  backend_image = var.backend_image
  frontend_container_port = var.frontend_container_port
  frontend_cpu = var.frontend_cpu
  frontend_memory = var.frontend_memory
  frontend_image = var.frontend_image
  alb_sg_id = ""
  frontend_sg_id = ""
  backend_sg_id = ""
}