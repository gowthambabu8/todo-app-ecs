    module "sg" {
      count = length(var.sg_names)
      source = "../../module"
      project = var.project
      environment = var.environment
      sg_name = var.sg_names[count.index]
      sg_desc = "Allow ssh traffic from backend services"
      vpc_id = var.vpc_id
    }