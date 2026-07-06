resource "aws_security_group" "main" {
  name = replace("${var.project}-${var.environment}-${var.sg_name}","_","-")
  description = var.sg_desc
  vpc_id = local.vpc_id
  tags = local.sg_final_tags
}

resource "aws_ssm_parameter" "sg_id" {
#  count = length(var.sg_names)
  name = "/${var.project}/${var.environment}/${var.sg_name}_sg_id"
  type = "String"
  value = aws_security_group.main.id
}
