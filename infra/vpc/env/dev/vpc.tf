module "vpc-main" {
    source = "../../module"
    project = var.project
    environment = var.environment
    cidr_block = var.cidr_block
    public_subnet_cidr = var.public_subnet_cidr
    private_subnet_cidr = var.private_subnet_cidr
    database_subnet_cidr = var.database_subnet_cidr
}