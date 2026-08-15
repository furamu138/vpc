variable "name_prefix" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "allow_ssh" {
  type    = bool
  default = false
}
