variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
  default = "jskjdgs"
}

variable "sg_names"{
  default = [ 
    # databases
    "frontend","backend","alb"
  ]
}