module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 6.0"

  identifier = "todo"

  engine               = "postgres"
  engine_version       = "16.4"
  family               = "postgres16"   # DB parameter group family
  major_engine_version = "16"           # DB option group
  instance_class       = "db.t3.micro"

  allocated_storage     = 20
  max_allocated_storage = 100           # enables storage autoscaling
  storage_type          = "gp3"
  storage_encrypted     = true

  db_name  = var.db_name
  username = var.db_username
  port     = 5432

  manage_master_user_password = false    # RDS manages password in Secrets Manager
  password = "Password123"

  multi_az               = false        # set true for prod HA
  publicly_accessible    = true
  vpc_security_group_ids = ["sg-0caa3557b03f54cd4"] # get from aws 

  create_db_subnet_group = true
  subnet_ids             = ["subnet-082a523d26a515299","subnet-0c2ad6d6bb2aba3b4"] # get from aws

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window       = "03:00-06:00"
  backup_retention_period = 7

  skip_final_snapshot = true            # set false for prod
  deletion_protection = false           # set true for prod

  performance_insights_enabled = false
  create_monitoring_role       = false

  tags = {
    Project     = var.project_name
    Environment = var.env
  }
}