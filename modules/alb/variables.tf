variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "instance_ids" {
  type = list(string)
}

variable "instance_security_group_id" {
  type = string
}

variable "certificate_arn" {
  type = string
}
