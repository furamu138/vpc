variable "nat_gateway_count" {
  type    = number
  default = 1
  validation {
    condition     = var.nat_gateway_count == 1 || var.nat_gateway_count == 3
    error_message = "nat_gateway_countは1または3を指定してください。"
  }
}
