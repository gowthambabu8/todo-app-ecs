## database services
module "mongo" {
  source = "../../module/"
  project = var.project
  environment = var.environment
}