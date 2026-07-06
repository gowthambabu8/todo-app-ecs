variable "project-name" {
  type = string
}

variable "env" {
  type = string
}

variable "backend_image" {
  type = string
}

variable "backend_container_port" {
  type = number
}

variable "aws_region" {
  type = string
}

variable "backend_cpu" {
  type = number
}

variable "backend_memory" {
  type = number
}

variable "frontend_image" {
  type = string
}

variable "frontend_container_port" {
  type = number
}

variable "frontend_cpu" {
  type = number
}

variable "frontend_memory" {
  type = number
}

variable "alb_sg_id" {
  type = string
}

variable "frontend_sg_id" {
  type = string
}

variable "backend_sg_id" {
  type = string
}