variable "name_prefix" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "db_subnet_ids" {
  type = list(string)
}

variable "username" {
  type = string
}

variable "password" {
  type      = string
  sensitive = true
}
