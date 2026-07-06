resource "aws_security_group_rule" "alb_internet" {
  type = "ingress"
  from_port = local.http_port
  to_port = local.http_port
  protocol = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ]
  security_group_id = local.alb_sg_id
}

resource "aws_security_group_rule" "frontend_alb" {
  type = "ingress"
  from_port = local.http_port
  to_port = local.http_port
  protocol = "tcp"
  source_security_group_id = local.alb_sg_id
  security_group_id = local.frontend_sg_id
}

resource "aws_security_group_rule" "backend_alb" {
  type = "ingress"
  from_port = local.backend_service_port
  to_port = local.backend_service_port
  protocol = "tcp"
  source_security_group_id = local.alb_sg_id
  security_group_id = local.backend_sg_id
}

resource "aws_vpc_security_group_egress_rule" "example" {
  count = length(local.sg_id_list)
  security_group_id = local.sg_id_list[count.index]
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = -1
  ip_protocol = "All"
  to_port     = -1
}