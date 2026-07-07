resource "aws_lb" "this" {
    name = "${var.project-name}-${var.env}"
    internal = false
    load_balancer_type = "application"
    security_groups = local.alb_sg_id
    subnets = local.public_subnets
    tags = {
        Name = "${var.project-name}"
        Environment = "${var.env}"
    }
}

resource "aws_lb_target_group" "frontend" {
  name = "frontend-service-${var.env}"
  target_type = "ip"
  protocol = "HTTP"
  port = "80"
  vpc_id = local.vpc_id

  health_check {
    path = "/health"
    interval = 30
    timeout = 5
    healthy_threshold = 2
    unhealthy_threshold = 2
    matcher = "200"
  }

  tags = {
        Name = "${var.project-name}-frontend-service-${var.env}"
        Environment = "${var.env}"
    }
}

resource "aws_lb_target_group" "backend" {
  name = "backend-service-${var.env}"
  target_type = "ip"
  protocol = "HTTP"
  port = "8000"
  vpc_id = local.vpc_id

  health_check {
    path = "/health"
    interval = 30
    timeout = 5
    healthy_threshold = 2
    unhealthy_threshold = 2
    matcher = "200"
  }

  tags = {
        Name = "${var.project-name}-backend-service-${var.env}"
        Environment = "${var.env}"
    }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  protocol = "HTTP"
  port = 80

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.frontend.arn
  }
}

resource "aws_lb_listener_rule" "name" {
  listener_arn = aws_lb_listener.http.arn
  priority = 10
  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.backend.arn
  }

  condition {
    path_pattern {
      values = ["/api/*"]
    }
  }
}

resource "aws_ssm_parameter" "tg_frontend" {
  name = "/${var.project-name}/${var.env}/tg_frontend"
  type = "String"
  value = aws_lb_target_group.frontend.arn
}

resource "aws_ssm_parameter" "tg_backend" {
  name = "/${var.project-name}/${var.env}/tg_backend"
  type = "String"
  value = aws_lb_target_group.backend.arn
}