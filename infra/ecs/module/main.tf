resource "aws_ecs_cluster" "this" {
  name = "${var.project-name}-ecs-cluster-${var.env}"
  setting {
    name = "containerInsights"
    value = "enabled"
  }
}

# backend - task def, service
resource "aws_ecs_task_definition" "backend-td" {
  family = "${var.project-name}-backend"
  requires_compatibilities = [ "FARGATE" ]
  network_mode = "awsvpc"
  cpu = var.backend_cpu
  memory = var.backend_memory
  execution_role_arn = "arn:aws:iam::105673693772:role/ecsTaskExecutionRole"
  #task_role_arn = ""

  container_definitions = jsonencode([
    {
      name      = "backend"
      image     = var.backend_image
      essential = true
      portMappings = [
        {
          containerPort = var.backend_container_port
          protocol      = "tcp"
        }
      ]
    #   environment = [
    #     for k, v in var.backend_env_vars : { name = k, value = v }
    #   ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/todo-backend"
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "backend-service" {
  name = "${var.project-name}-backend-service"
  cluster = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.backend-td.arn
  desired_count = 1
  launch_type = "FARGATE"

  network_configuration {
    subnets = local.public_subnets
    security_groups = [ local.backend_sg_id ]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = local.tg_backend
    container_name = "backend"
    container_port = 8000
  }
}

# frontend - task def, service
resource "aws_ecs_task_definition" "frontend-td" {
  family = "${var.project-name}-frontend"
  requires_compatibilities = [ "FARGATE" ]
  network_mode = "awsvpc"
  cpu = var.frontend_cpu
  memory = var.frontend_memory
  execution_role_arn = "arn:aws:iam::105673693772:role/ecsTaskExecutionRole"
  #task_role_arn = ""

  container_definitions = jsonencode([
    {
      name      = "frontend"
      image     = var.frontend_image
      essential = true
      portMappings = [
        {
          containerPort = var.frontend_container_port
          protocol      = "tcp"
        }
      ]
    #   environment = [
    #     for k, v in var.backend_env_vars : { name = k, value = v }
    #   ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/todo-frontend"
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "frontend-service" {
  name = "${var.project-name}-frontend-service"
  cluster = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.frontend-td.arn
  desired_count = 1
  launch_type = "FARGATE"

  network_configuration {
    subnets = local.public_subnets
    security_groups = [ local.frontend_sg_id ]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = local.tg_frontend
    container_name = "frontend"
    container_port = 80
  }
}