variable "project_name" {
  type        = string
  description = "Project name used for resource names and tags."
  default     = "myamae"

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{0,11}$", var.project_name))
    error_message = "project_name must start with a lowercase letter and contain at most 12 lowercase letters, numbers, or hyphens."
  }
}

variable "environment" {
  type        = string
  description = "Environment name used for resource names and tags."
  default     = "dev"

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{0,7}$", var.environment))
    error_message = "environment must start with a lowercase letter and contain at most 8 lowercase letters, numbers, or hyphens."
  }
}

variable "db_password" {
  type      = string
  sensitive = true
}
