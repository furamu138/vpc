variable "vpc_id" {
  type = string
}

variable "ec2_security_group_id" {
  type = string
}

variable "db_subnet_group_name" {
  type = string
}

variable "username" {
  type = string
}

variable "password" {
  type      = string
  sensitive = true
}