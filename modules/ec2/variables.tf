variable "allow_ssh" {
  type = bool
}

variable "subnet_ids" {
  type = list(string)
}

variable "instance_count" {
  type    = number
  default = 1

  validation {
    condition     = var.instance_count >= 1 && var.instance_count <= 3
    error_message = "instance_countは1〜3の範囲で指定してください。"
  }
}